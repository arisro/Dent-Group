class Job < ActiveRecord::Base
	searchkick
	
	include Rails.application.routes.url_helpers

	self.inheritance_column = nil

	belongs_to :user

	has_attached_file :image, :styles => { :thumb => "150x150>" }, :default_url => "/images/job_:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_file_name :image, :matches => [/png\Z/i, /jpe?g\Z/i]

	#has_paper_trail ignore: [:views, :updated_at]

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
