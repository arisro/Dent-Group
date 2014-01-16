class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, :alert => exception.message
	end

	protected
		def not_found
			raise raise ActiveRecord::RecordNotFound.new
		end

		def authenticate_admin_user!
			#redirect_to new_user_session_path unless current_user.try(:is_admin?) 
			redirect_to new_user_session_path unless user_signed_in?
		end

		def user_for_paper_trail
			user_signed_in? ? current_user : User.find(1)
		end

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) do |u|
				u.permit(:fname, :lname, :email, :password, :password_confirmation)
			end
			devise_parameter_sanitizer.for(:account_update) do |u|
				u.permit(:fname, :lname, :email, :current_password, :password, :password_confirmation, :pic_name, :specialization)
			end
		end
end
