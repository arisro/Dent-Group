class BadCustomerCommentsController < ApplicationController	
	def create
		@comment = BadCustomerComment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.bad_customer_id = params[:bad_customer_id]
		if @comment.save
      		redirect_to @comment.bad_customer
		else
			render 'new'
		end
	end

	def destroy
		@comment = BadCustomerComment.find(params[:id])
		@comment.update_attributes(deleted: true)
		redirect_to bad_customer_path(@comment.bad_customer.id)
	end

	private
		def comment_params
			params.require(:bad_customer_comment).permit(:body)
		end
end
