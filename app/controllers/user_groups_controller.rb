class UserGroupsController < ApplicationController
  ACTIVITIES_PER_PAGE = 5

  def feed
    if user_signed_in?
      session[:return_to] = request.original_url

      @user = current_user
      @status = Status.new
      @status_comment = StatusComment.new
      @upload = Upload.new

      user_group_ident = params[:user_group_ident] || get_country
      @user_group = UserGroup.where(ident: user_group_ident).first
      @activities = @user_group.activities.order('created_at DESC').page(params[:page]).per(ACTIVITIES_PER_PAGE)

      respond_to do |format|
        format.js
        format.html
      end
    else
      render file: 'dashboard/lp'
    end
  end
end
