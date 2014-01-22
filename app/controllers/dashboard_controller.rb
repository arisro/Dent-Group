class DashboardController < ApplicationController
	layout :dashboard_layout
	before_filter :deny_not_paid

	def index
		
	end

	def change_language
		session[:current_language] = params[:language] unless params[:language].nil?
		I18n.locale = session[:current_language]
		redirect_to '/'
	end

	private
		def dashboard_layout
			params[:action] == 'index' && current_user.nil? ? 'landingpage' : nil
		end
end