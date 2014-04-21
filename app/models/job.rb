class Job < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	searchkick

	self.inheritance_column = nil

	belongs_to :user

	has_paper_trail ignore: [:views]

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:title, :description, :company_name, :country, :city]
	end

	def admin_permalink
		admin_job_path(self)
	end
end
