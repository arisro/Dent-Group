class HomepageMessagesController < ApplicationController
	def index
		@messages = HomepageMessage.where(deleted: false, website_country: get_country).order("id desc").page(params[:page]).per(10)
	end

	def new
		@message = HomepageMessage.new
	end

	def create
		@message = HomepageMessage.new(page_params)
		@message.user_id = current_user.id
		@message.website_country = get_country
		if @message.save
			flash[:success] = "Homepage message created."
      		redirect_to @message
		else
			render 'new'
		end
	end

	def edit
		@message = HomepageMessage.where(deleted: false, id: params[:id]).first
		not_found if @message.nil?
	end

	def update
		@message = HomepageMessage.where(deleted: false, id: params[:id]).first
		not_found if @message.nil?
		if @message.update_attributes(page_params)
			flash[:success] = "Homepage message updated."
      		redirect_to @message
		else
			render 'edit'
		end
	end

	def show
		@message = HomepageMessage.where(deleted: false, id: params[:id]).first
		not_found if @message.nil?
	end

	def destroy
		@HomepageMessage = HomepageMessage.find(params[:id]).update_attributes(deleted: true)
		redirect_to homepage_messages_path
	end

	private
		def page_params
			params.require(:homepage_message).permit(:title, :body, :published_at, :website_country)
		end
end