class StatusUpload < ActiveRecord::Base
	self.table_name = "statuses_uploads"

	belongs_to :status
  	belongs_to :upload
end