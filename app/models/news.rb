class News < ActiveRecord::Base
	searchkick

	has_many :news_comments
	belongs_to :user
  belongs_to :news_category

	has_attached_file :image, :styles => { :thumb => "150x150>" }, :default_url => "/images/news_:style/missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:title, :summary, :body, :website_country, :published_at]
	end

	def comments_count
		news_comments.where(deleted: false).length
	end
end
