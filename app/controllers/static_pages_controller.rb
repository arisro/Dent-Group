class StaticPagesController < ApplicationController
	before_filter :deny_not_paid, except: [:about, :subscriptions]

	def about
		
	end

	def subscriptions

	end
end
