class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  searchkick

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :statuses
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :chat_ignores, class_name: "ChatIgnore", foreign_key: 'by_user_id'
  has_many :chat_ignored, class_name: "ChatIgnore", foreign_key: 'on_user_id'

  has_and_belongs_to_many :user_groups

  ROLES = %w[visitor user moderator admin]

  has_paper_trail

  validates :fname, :lname, presence: true

  scope :filter, -> (query) { where("fname like ? OR lname like ?", "%#{query}%", "%#{query}%")}
  scope :online, -> { where(is_online: true) }
  scope :chat_visible, -> { where(chat_is_invisible: false) }

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

  # searchkick stuff
  def should_index?
    true
  end
  def search_data
    as_json only: [:fname, :lname, :specialization, :country, :city]
  end

	def admin_permalink
		admin_user_path(self)
	end

  # login after registration
  def active_for_authentication?
    true
  end

  def chat_ignored_by?(user_id)
    !!chat_ignored.find_by(by_user_id: user_id)
  end

  def activities
    # Activity.where("from_user_id = #{self.id}").where(country: country).order('created_at DESC')
    Activity.where("from_user_id = #{self.id}").order('created_at DESC')
  end

  def feed(user_group_id)
    Activity.where("from_user_id = #{self.id} OR from_user_id in (?)", followed_users.pluck(:id).join(",")).where(user_group_id: user_group_id).order('created_at DESC')
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

  def admin?
    is?('admin')
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
end