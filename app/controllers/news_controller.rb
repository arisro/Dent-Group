class NewsController < ApplicationController
	before_filter :authorize_paid_user
  after_action :verify_authorized, except: [:index, :show]

	def index
		@news = News.where(deleted: false, website_country: get_country).where("published_at <= ?", Time.now).order("id desc").page(params[:page]).per(9)
		@columns = 3

		respond_to do |format|
			format.js
			format.html
		end
	end

	def new
		@news = News.new
		@news.published_at = Time.now
    authorize @news
	end

	def create
		@news = News.new(news_params)
    authorize @news
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
    authorize @news
		not_found if @news.nil?
	end

	def update
		@news = News.where(deleted: false, id: params[:id]).first
		not_found if @news.nil?
    authorize @news
		if @news.update_attributes(news_params)
			flash[:success] = "News updated!"
      		redirect_to @news
		else
			render 'edit'
		end
	end

	def show
		@news = News.where(deleted: false, id: params[:id]).first
		not_found if @news.nil?
		@news.increment!(:views)
		@comments = @news.news_comments.where(deleted: false)
		@comment = NewsComment.new
	end

	def destroy
		@news = News.find(params[:id])
    authorize @news
    @news.update_attributes(deleted: true)
		redirect_to news_index_path
	end

	private
		def news_params
			params.require(:news).permit(:title, :summary, :body, :published_at, :image)
		end
end
