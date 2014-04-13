class DashboardController < ApplicationController
	layout :dashboard_layout
	
	def index
		if user_signed_in?
			@message = HomepageMessage.where( website_country: get_country ).first
		else
			render file: 'dashboard/lp'
		end
	end

	def change_language
		session[:current_language] = params[:language] unless params[:language].nil?
		I18n.locale = session[:current_language]
		redirect_to '/'
	end

	private
		def dashboard_layout
			# params[:action] == 'index' && current_user.nil? ? 'landingpage' : nil
			params[:action] == 'index' && current_user.nil? ? 'landingpage2' : nil
		end
end