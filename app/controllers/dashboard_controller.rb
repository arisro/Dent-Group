class DashboardController < ApplicationController
	layout :dashboard_layout

	def index
		
	end

	private
		def dashboard_layout
			params[:action] == 'index' && current_user.nil? ? 'landingpage' : nil
		end
end