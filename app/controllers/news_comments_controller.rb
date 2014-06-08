class NewsCommentsController < ApplicationController	
	def create
		@comment = NewsComment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.news_id = params[:news_id]
		if @comment.save
      		redirect_to @comment.news
		else
			render 'new'
		end
	end

	def destroy
		@comment = NewsComment.find(params[:id])
    authorize @comment
		@comment.update_attributes(deleted: true)
		redirect_to news_path(@comment.news.id)
	end

	private
		def comment_params
			params.require(:news_comment).permit(:body)
		end
end
