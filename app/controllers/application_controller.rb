class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :configure_permitted_parameters, if: :devise_controller?

	protected
		def not_found
			raise raise ActiveRecord::RecordNotFound.new
		end

		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) do |u|
				u.permit(:fname, :lname, :email, :password, :password_confirmation)
			end
			devise_parameter_sanitizer.for(:account_update) do |u|
				u.permit(:fname, :lname, :email, :current_password, :password, :password_confirmation, :avatar)
			end
		end
end
