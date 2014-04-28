class Supplier < ActiveRecord::Base
	searchkick
	
	belongs_to :user

	has_many :supplier_comments

	has_attached_file :image, :styles => { :thumb => "150x150>" }, :default_url => "/images/supplier_:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:name, :description, :website, :country, :city, :address, :website_country]
	end

	def comments_count
		supplier_comments.where(deleted: false).length
	end
end