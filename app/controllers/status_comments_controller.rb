class StatusCommentsController < ApplicationController
	def create
		@comment = StatusComment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.status_id = params[:status_id]

		if @comment.save
			prev_url = session.delete(:return_to) || user_path(@comment.status.user.id)
			redirect_to prev_url
		else
			render 'dashboard/index'
		end
	end

	def destroy
		StatusComment.find(params[:id]).update_attributes(deleted: true)
		redirect_to feed_path
	end

	private
		def comment_params
			params.require(:status_comment).permit(:message)
		end
end
