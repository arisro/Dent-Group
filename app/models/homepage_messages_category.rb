class HomepageMessagesCategory < ActiveRecord::Base
  has_many :homepage_messages, counter_cache: true

  def to_label
    "#{ident}"
  end
end
