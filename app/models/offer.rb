class Offer < ActiveRecord::Base
	self.inheritance_column = nil
	
	belongs_to :user
end