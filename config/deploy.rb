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

set :deploy_to, "/var/www/com.buzachis-aris.drs"
set :rails_env, "development"
set :user, 'aris'

# server "drs.buzachis-aris.com", :app, :web, :db, :primary => true, user: 'aris', rails_env: "development"

task :production do
  server "www.dentgroup.eu", :app, :web, :db, :primary => true
  set :deploy_to, "/var/www/com.dent-group.www"
  set :rails_env, "production"
end

task :staging do
  server "drs.buzachis-aris.com", :app, :web, :db, :primary => true
  set :deploy_to, "/var/www/com.buzachis-aris.drs"
  set :rails_env, "development"
end

namespace :deploy do
  task :copy_config_files do
    put File.read("config/unicorn.rb.deploy"), "#{shared_path}/config/unicorn.rb"
    put File.read("config/initializers/secret_token.rb.dist"), "#{shared_path}/config/secret_token.rb"
    
    put File.read("config/unicorn_init.sh"), "#{shared_path}/config/unicorn_init.sh"
    run "#{try_sudo} chmod +x #{shared_path}/config/unicorn_init.sh && #{try_sudo} ln -nfs #{deploy_to}/shared/config/unicorn_init.sh /etc/init.d/unicorn_#{application}_#{rails_env}"
  end
  after "deploy:setup", "deploy:copy_config_files"
  
  desc "Symlink shared config files"
  task :symlink_config_files do
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/database.yml #{deploy_to}/releases/#{release_name}/config/database.yml"
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/unicorn.rb #{deploy_to}/releases/#{release_name}/config/unicorn.rb"      
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/config/secret_token.rb #{deploy_to}/releases/#{release_name}/config/initializers/secret_token.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config_files"

  desc "Symlink uploads"
  task :symlink_uploads_folders do
      run "#{try_sudo} rm -Rf #{deploy_to}/releases/#{release_name}/public/temp_profile_pictures"
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/uploads/temp_profile_pictures #{deploy_to}/releases/#{release_name}/public"

      run "#{try_sudo} rm -Rf #{deploy_to}/releases/#{release_name}/public/profile_pictures"
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/uploads/profile_pictures #{deploy_to}/releases/#{release_name}/public"

      run "#{try_sudo} rm -Rf #{deploy_to}/releases/#{release_name}/public/ckeditor_assets"
      run "#{try_sudo} ln -nfs #{deploy_to}/shared/uploads/ckeditor_assets #{deploy_to}/releases/#{release_name}/public"

      run "#{try_sudo} rm -Rf #{deploy_to}/releases/#{release_name}/public/assets/*.json"
  end
  after "deploy:finalize_update", "deploy:symlink_uploads_folders"
  
  task :custom_bundle_install, roles: :app do
    run "cd #{deploy_to}/releases/#{release_name} && NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install --gemfile #{deploy_to}/releases/#{release_name}/Gemfile --path #{deploy_to}/shared/bundle --deployment --quiet --without development test"
  end
  before "bundle:install", "deploy:custom_bundle_install"

  desc 'copy ckeditor nondigest assets'
  task :copy_nondigest_assets, roles: :app do
    run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:create_nondigest_assets"
  end
  after 'deploy:assets:precompile', 'deploy:copy_nondigest_assets'

  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake paperclip:refresh:missing_styles"
  end
  after("deploy:assets:precompile", "deploy:build_missing_paperclip_styles")
  
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "#{try_sudo} /etc/init.d/unicorn_#{application}_#{rails_env} #{command}"
    end
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do 
      run_locally("rm -rf public/assets/*") 
      run_locally("RAILS_ENV=#{rails_env} bundle exec rake assets:precompile --trace") 
      servers = find_servers_for_task(current_task) 
      port = 443
      port_option = port ? " -e 'ssh -p #{port}' " : '' 
      servers.each do |server| 
        run_locally("rsync --recursive --times --rsh=ssh --compress #{port_option} --progress public/assets #{user}@#{server}:#{shared_path}") 
      end 
    end
  end
end

after 'deploy:finalize_update', 'deploy:migrate'