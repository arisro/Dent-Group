class DashboardController < ApplicationController
	layout :dashboard_layout
	
	def index
		#if user_signed_in? && current_user.is_paid?
    # if user_signed_in? && current_user.confirmed?
	    if user_signed_in?
	      where = { website_country: get_country, deleted: false }
	   
	      @category = nil
	      unless params[:category_id].nil?
	        @category = HomepageMessagesCategory.find(params[:category_id])
	        where[:homepage_messages_category_id] = params[:category_id]
	      end

	      @messages = HomepageMessage.where(where).limit(10)
	      @latest = HomepageMessage.where(website_country: get_country, deleted: false)[0, 5]
	      @categories = HomepageMessagesCategory.joins("LEFT JOIN homepage_messages ON homepage_messages_categories.id = homepage_messages.homepage_messages_category_id").select("homepage_messages_categories.*, count(homepage_messages.id) as msgs_count").group("homepage_messages_categories.id").where(deleted: false).where("homepage_messages.website_country = ?", get_country).having("msgs_count > 0").order(ident: :asc).order('msgs_count desc')
		else
			render file: 'dashboard/lp'
		end
	end

	def change_language
		session[:current_language] = params[:language] unless params[:language].nil?
		I18n.locale = session[:current_language]
		redirect_to '/'
	end

	def search
		@results = []
		@query = params[:query]

		[News, Offer, Job, Supplier].each do |model|
			query = Searchkick::Query.new model, @query, load: true, operator: "or", limit: 100
			@results = @results.concat query.execute.response['hits']['hits']
		end

		@results.sort_by! { |r| r['_score'] }.reverse!

		@results.each do |res|
			res[:object] = res['_type'].classify.constantize.find(res['_id'])
		end
		
		@total_results = @results.count
		@results = Kaminari.paginate_array(@results).page(params[:page]).per(10)
	end

	private
		def dashboard_layout
			#params[:action] == 'index' && (!user_signed_in? || !current_user.is_paid?) ? 'landingpage2' : nil
			#params[:action] == 'index' && (!user_signed_in? || !current_user.confirmed?) ? 'landingpage2' : nil
			params[:action] == 'index' && (!user_signed_in?) ? 'landingpage2' : nil
		end

		# disable this check
		def authorize_paid_user
			true
		end
end