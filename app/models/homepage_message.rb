class HomepageMessage < ActiveRecord::Base
  belongs_to :homepage_messages_category
	default_scope order('priority DESC, published_at DESC')
end
