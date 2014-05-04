class ChatMessage < ActiveRecord::Base
	belongs_to :from, class_name: "User", foreign_key: "from_user_id"
	belongs_to :to, class_name: "User", foreign_key: "to_user_id"

	scope :lookup, -> (from_user_id, to_user_id) { where("(from_user_id = ? and to_user_id = ?) or (to_user_id = ? and from_user_id = ?)", from_user_id, to_user_id, from_user_id, to_user_id) }
end
