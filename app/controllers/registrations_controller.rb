class RegistrationsController < Devise::RegistrationsController
	def update
		@user = User.find(current_user.id)

		successfully_updated = if needs_password?(@user, params)
			@user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
		else
			params[:user].delete(:password)
			params[:user].delete(:current_password)
			@user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
		end

		if successfully_updated
			set_flash_message :notice, :updated
			sign_in @user, :bypass => true
			redirect_to after_update_path_for(@user)
		else
			render "edit"
		end
	end

	def sign_up(resource_name, resource)
		flash[:notice] = t('signup_welcome')
		sign_in(resource_name, resource)
	end

	private
		def needs_password?(user, params)
			user.email != params[:user][:email] ||
			params[:user][:password].present?
		end

		def after_update_path_for(resource)
			user_path(resource)
		end
end