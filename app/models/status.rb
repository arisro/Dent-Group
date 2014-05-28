class Status < ActiveRecord::Base
	validates :message, presence: true

	belongs_to :user
	has_many :status_comments

	has_many :status_upload
	has_many :uploads, :through => :status_upload
	

	after_create :create_activities
	after_save :handle_delete

	default_scope where('deleted = 0')

	private
		def create_activities
			Activity.create(
				subject: self,
				name: 'status_posted',
				country: country,
				from_user_id: user.id,
				user_group_id: user_group_id,
			)
		end

		def handle_delete
			if deleted?
				Activity.where(name: 'status_posted', subject_id: id).destroy_all
				status_comments.update_all(deleted: true)
			end
		end
end