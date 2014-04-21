class PasswordsController < Devise::PasswordsController
	respond_to :json

	def edit
		sign_out current_user unless current_user.nil?
		
		session[:reset_password_token] = params[:reset_password_token]
		redirect_to root_url
	end

	def update
		self.resource = resource_class.reset_password_by_token(params[resource_name])

		if resource.errors.empty?
			sign_in(resource_name, resource)
			render json: {}, status: :ok
		else
			render json: resource.errors.messages, status: :unprocessable_entity
		end
	end
end