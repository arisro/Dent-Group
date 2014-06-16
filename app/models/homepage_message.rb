class HomepageMessage < ActiveRecord::Base
  belongs_to :homepage_messages_category
	default_scope order('created_at DESC')
end
