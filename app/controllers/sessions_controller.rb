class SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    sign_out(:user) if warden.authenticated?(:user)
    warden.authenticate(:database_authenticatable, scope: :user)
    if warden.authenticated?(:user)
      @user = warden.user
      sign_in(:user, @user)
      head :created
    else
      invalid_login_attempt
    end
  end
  
  def destroy
    @user = current_user
    signed_out = sign_out(:user)
    head :no_content
  end
  
  private
  
  def invalid_login_attempt
    warden.custom_failure!
    render json: {error: "Invalid email or password"}, status: 401
  end
end