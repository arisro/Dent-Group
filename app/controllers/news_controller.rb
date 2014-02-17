class NewsController < ApplicationController	
	def index
		@news = News.where(deleted: false, website_country: get_country).where("published_at <= ?", Time.now).order("id").page(params[:page]).per(10)
		@columns = 3
	end

	def new
		@news = News.new
		@news.published_at = Time.now
	end

	def create
		@news = News.new(news_params)
		@news.user_id = current_user.id
		@news.website_country = get_country
		if @news.save
			flash[:success] = "News posted!"
      		redirect_to @news
		else
			render 'new'
		end
	end

	def edit
		@news = News.where(deleted: false, id: params[:id]).first
		not_found if @news.nil?
	end

	def update
		@news = News.where(deleted: false, id: params[:id]).first
		not_found if @news.nil?
		if @news.update_attributes(news_params)
			flash[:success] = "News updated!"
      		redirect_to @news
		else
			render 'edit'
		end
	end

	def show
		@news = News.where(deleted: false, id: params[:id], website_country: get_country).first
		not_found if @news.nil?
		@news.increment!(:views)
	end

	def destroy
		@news = News.find(params[:id]).update_attributes(deleted: true)
		redirect_to jobs_path
	end

	private
		def news_params
			params.require(:news).permit(:title, :summary, :body, :published_at)
		end
end
