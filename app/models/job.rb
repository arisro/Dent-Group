class Job < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	self.inheritance_column = nil

	belongs_to :user

	has_paper_trail ignore: [:views]

	def admin_permalink
		admin_job_path(self)
	end
end
