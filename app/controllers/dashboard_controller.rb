class DashboardController < ApplicationController
	layout :dashboard_layout
	
	def index
		if user_signed_in? && current_user.is_paid?
			@messages = HomepageMessage.where( website_country: get_country ).limit(10)
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

		[News, Offer, User, Job, Supplier].each do |model|
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
			params[:action] == 'index' && (!user_signed_in? || !current_user.is_paid?) ? 'landingpage2' : nil
		end

		# disable this check
		def authorize_paid_user
			true
		end
end