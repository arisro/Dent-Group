class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_paper_trail

  validates :fname, :lname, presence: true

  def full_name
  	"#{fname} #{lname}"
  end

	def admin_permalink
		admin_user_path(self)
	end
end