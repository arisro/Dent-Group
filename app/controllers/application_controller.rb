class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# protect_from_forgery with: :exception

	before_action :set_locale
	before_action :set_country
	before_filter :configure_permitted_parameters, if: :devise_controller?
	before_filter :get_online_users

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :alert => exception.message
	end

	protected
		def get_online_users
			@online_users = User.all.limit(10)
		end

		def deny_not_paid
			redirect_to about_url if user_signed_in? && !current_user.is_paid?
		end

		def set_locale
			I18n.locale = session[:current_language] if session.has_key?(:current_language)
			I18n.locale = current_user.language if user_signed_in?
		end

		def set_country
			session[:current_country] = params[:country] unless params[:country].nil?
		end

		def get_country
			session[:current_country]
		end

		def default_url_options(options={})
			session[:current_country].nil? ? {} : { country: session[:current_country] } 
		end

		def not_found
			raise raise ActiveRecord::RecordNotFound.new
		end

		def authenticate_admin_user!
			redirect_to root_url unless current_user.is? :admin
		end

		def user_for_paper_trail
			user_signed_in? ? current_user : User.find(1)
		end

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) do |u|
				u.permit(:fname, :lname, :email, :password, :password_confirmation, :language)
			end
			devise_parameter_sanitizer.for(:account_update) do |u|
				u.permit(:fname, :lname, :email, :current_password, :password, :password_confirmation, :pic_name, :specialization, :language)
			end
		end
end
