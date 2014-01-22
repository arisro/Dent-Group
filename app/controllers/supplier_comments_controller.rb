class SupplierCommentsController < ApplicationController
	before_filter :deny_not_paid
	
	def create
		@comment = SupplierComment.new(comment_params)
		@comment.user_id = current_user.id
		@comment.supplier_id = params[:supplier_id]
		if @comment.save
      		redirect_to @comment.supplier
		else
			render 'new'
		end
	end

	def destroy
		@comment = SupplierComment.find(params[:id])
		@comment.update_attributes(deleted: true)
		redirect_to supplier_path(@comment.supplier.id)
	end

	private
		def comment_params
			params.require(:supplier_comment).permit(:body)
		end
end
