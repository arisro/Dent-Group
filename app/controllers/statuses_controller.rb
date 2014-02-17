class StatusesController < ApplicationController
	def create
		@status = Status.new(status_params)
		@status.user_id = current_user.id
		@status.country = get_country

		if @status.save
			unless params[:images].nil?
				params[:images].each {|upid| @status.uploads << Upload.find(upid) }
			end

			redirect_to feed_path
		else
			render 'users/feed'
		end
	end

	def destroy
		Status.find(params[:id]).update_attributes(deleted: true)
		redirect_to feed_path
	end

	private
		def status_params
			params.require(:status).permit(:message)
		end
end
