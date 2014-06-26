class Offer < ActiveRecord::Base
	self.inheritance_column = nil

	searchkick
	
	belongs_to :user

	has_attached_file :image, :styles => { :thumb => "150x150>", large: "1500x1500>" }, :default_url => "/images/offers_:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_file_name :image, :matches => [/png\Z/i, /jpe?g\Z/i]

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:title, :body, :summary, :website_country, :created_at]
	end
end