class UsersController < ApplicationController
  before_filter :deny_not_paid

  def feed
    if user_signed_in?
      @status = Status.new
      @status_comment = StatusComment.new
      @activities = current_user.activities(10, get_country)
      @upload = Upload.new
    else
      render file: 'dashboard/lp'
    end
  end

  def index
    redirect_to root_path
  end
  
	def show
		@user = User.find(params[:id])
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
    @users = @user.followed_users.page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow'
  end
end
