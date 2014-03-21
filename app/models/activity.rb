class Activity < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: "from_user_id"
  belongs_to :target, class_name: "User", foreign_key: "to_user_id"
end
