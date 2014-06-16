class NewsCategory < ActiveRecord::Base
  has_many :news

  def to_label
    "#{ident}"
  end
end
