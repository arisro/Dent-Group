class ApplicationController < ActionController::Base
  include Pundit

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :set_locale
	before_action :set_country
	before_filter :configure_permitted_parameters, if: :devise_controller?
	before_action :get_specializations

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	protected
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
			session[:current_country].nil? ? { country: 'int' } : { country: session[:current_country] } 
		end

		def not_found
			raise raise ActiveRecord::RecordNotFound.new
		end

		def authenticate_admin_user!
			redirect_to root_url unless current_user.is? :admin
		end

		def authorize_paid_user
			#redirect_to root_url unless user_signed_in? && current_user.is_paid?
      redirect_to root_url unless user_signed_in? && current_user.confirmed?
		end
    
		# def user_for_paper_trail
		# 	user_signed_in? ? current_user : User.find(1)
		# end

		def get_specializations
			country = get_country
			if country == 'int'
				@menu_specializations = ['surgery','orthodontics','prosthetics', 'endodontics']
			else
				@menu_specializations = ["#{country}.surgery","#{country}.orthodontics","#{country}.prosthetics", "#{country}.endodontics"]
			end
			@menu_specializations = UserGroup.where("ident IN (?)", @menu_specializations)
		end

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) do |u|
				u.permit(:fname, :lname, :email, :password, :password_confirmation, :language)
			end
			devise_parameter_sanitizer.for(:account_update) do |u|
				u.permit(:fname, :lname, :email, :current_password, :password, :password_confirmation, :pic_name, :specialization, :language, :country, :city, :phone, :skype, :yahoo)
			end
		end

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to (request.referrer || root_path)
    end

    def after_sign_in_path_for(resource)
      root_path
    end
end
