require "bundler/capistrano" 
require "capistrano-unicorn"
require "rvm/capistrano"

set :application, "DRS"
set :repository,  "git@github.com:arisro/drs.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true, :port => 443 }
set :keep_releases, 5

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
set :rvm_ruby_string, '2.0.0-p353'

server "drs.buzachis-aris.com", :app, :web, :db, :primary => true

set :deploy_to, "/var/www/com.buzachis-aris.drs"
set :user, "aris"
set :use_sudo, false

set :rails_env, "production"
set(:unicorn_env) { rails_env }

namespace :deploy do
  desc "Symlink shared config files"
  task :symlink_config_files do
      run "#{try_sudo} ln -s #{deploy_to}/shared/config/database.yml #{deploy_to}/releases/#{release_name}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config_files"
  
  task :setup_config do
    run "#{try_sudo} ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end
  after "deploy:setup", "deploy:setup_config"
  
  task :custom_bundle_install, roles: :app do
    run "cd #{deploy_to}/releases/#{release_name} && NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install --gemfile #{deploy_to}/releases/#{release_name}/Gemfile --path #{deploy_to}/shared/bundle --deployment --quiet --without development test"
  end
  before "bundle:install", "deploy:custom_bundle_install"
  
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
end


after 'deploy:finalize_update', 'deploy:migrate'
after 'deploy:restart', 'unicorn:reload'
after 'deploy:restart', 'unicorn:restart'