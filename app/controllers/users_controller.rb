class UsersController < ApplicationController
  before_filter :authorize_paid_user, except: [:set_payed, :cancel_reset_password]

  ACTIVITIES_PER_PAGE = 5

  def activity
    @user = User.find(params[:id])
    @activities = @user.activities.page(params[:page]).per(ACTIVITIES_PER_PAGE)
    @status_comment = StatusComment.new

    respond_to do |format|
      format.js
    end
  end

  def index
    redirect_to root_path
  end
  
	def show
    session[:return_to] = request.original_url

		@user = User.find(params[:id])
    @activities = @user.activities.page(params[:page]).per(ACTIVITIES_PER_PAGE)
    @status_comment = StatusComment.new
    @no_forms = true

    render 'feed'
	end

	def upload_profile_picture
		require 'fileutils'
		
		tmp = params[:profile_picture].tempfile
		original_name = params[:profile_picture].original_filename
		@file = File.join("public", "temp_profile_pictures", "#{current_user.id}#{File.extname(original_name)}")
  		FileUtils.cp tmp.path, @file
  		FileUtils.chmod 0644, @file

  		@size = FastImage.size(@file)
  		@filename = File.basename(@file)

		respond_to do |format|
			format.js
		end
	end

	def save_profile_picture
		# if has picture
		filename = params[:filename]
		temp_path = File.join("public", "temp_profile_pictures", filename)

		# original size path / crop the file
  		original_size_path = File.join("public", "profile_pictures", filename)
  		cropx, cropy, cropw, croph = params[:cropx], params[:cropy], params[:cropw], params[:croph]
  		image = MiniMagick::Image.open(temp_path)
  		image.crop("#{cropw}x#{croph}+#{cropx}+#{cropy}")
		  image.write original_size_path

  		FileUtils.rm(temp_path)
  		
  		# create 80x80 thumb
  		thumb_path = File.join("public", "profile_pictures", "thumbs", filename)
  		image = MiniMagick::Image.open(original_size_path)
  		image.resize "80x80"
  		image.write  thumb_path

  		# create 120x120 thumb
  		thumb_path = File.join("public", "profile_pictures", "thumbs2", filename)
  		image = MiniMagick::Image.open(original_size_path)
  		image.resize "120x120"
  		image.write  thumb_path

  		current_user.update_attribute('profile_picture', filename)

  		render json: { status: "OK"}
	end

  def following
    @title = "Following"
    @user = User.find(params[:id])

    respond_to do |format|
      format.html {
        @users = @user.followed_users.page params[:page]
        render 'show_follow'
      }
      format.json {
        @users = @user.followed_users.where(is_online: true)
        @final_users = []
        @users.each do |user|
          @final_users.push({
            user_id: user.id,
            user_name: user.full_name,
            specialization: user.specialization,
            profile_picture: user.get_profile_picture,
            is_ignored: user.chat_ignored_by?(current_user.id)
          })
        end
        render json: {data: @final_users}
      }
    end
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow'
  end

  def set_payed
    unless user_signed_in?
      render json: { status: :unprocessable_entity}
    else
      current_user.paid_until = Time.now() + 30.days
      current_user.save
      render json: { status: :ok}
    end
  end

  def cancel_reset_password
    session.delete(:reset_password_token)
    render json: { status: :ok}
  end
end
