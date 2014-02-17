class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :statuses

  ROLES = %w[visitor user moderator admin]

  has_paper_trail

  validates :fname, :lname, presence: true

  def full_name
  	"#{fname} #{lname}"
  end

  def get_profile_picture
    profile_picture || '0.png'
  end

  def is_paid?
    false if paid_until.nil?
    paid_until > Time.now unless paid_until.nil?
  end

	def admin_permalink
		admin_user_path(self)
	end

  # login after registration
  def active_for_authentication?
    true
  end

  def activities(limit, country)
    Activity.where("user_id = 0 or user_id = #{ self.id } ").where(country: country).order('created_at DESC').limit(limit)
  end

  # CAN CAN
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end