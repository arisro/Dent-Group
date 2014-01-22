class SupplierComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :supplier

	default_scope { order('created_at DESC') }
end
