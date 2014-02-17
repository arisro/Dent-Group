class StatusCommentsController < ApplicationController
	def create
		@comment = StatusComment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.status_id = params[:status_id]

		if @comment.save
			redirect_to root_path
		else
			render 'dashboard/index'
		end
	end

	def destroy
		StatusComment.find(params[:id]).update_attributes(deleted: true)
		redirect_to root_path
	end

	private
		def comment_params
			params.require(:status_comment).permit(:message)
		end
end
