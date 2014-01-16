class BadCustomersController < ApplicationController
	def index
		@customers = BadCustomer.where(deleted: false).order("id").page(params[:page]).per(10)
	end

	def new
		@customer = BadCustomer.new
	end

	def create
		@customer = BadCustomer.new(bad_customer_params)
		@customer.user_id = current_user.id
		if @customer.save
			flash[:success] = "Customer reported!"
      		redirect_to @customer
		else
			render 'new'
		end
	end

	def edit
		@customer = BadCustomer.where(deleted: false, id: params[:id]).first
		not_found if @customer.nil?
	end

	def update
		@customer = BadCustomer.where(deleted: false, id: params[:id]).first
		not_found if @customer.nil?
		if @customer.update_attributes(bad_customer_params)
			flash[:success] = "Customer report updated!"
      		redirect_to @customer
		else
			render 'edit'
		end
	end

	def show
		@customer = BadCustomer.where(deleted: false, id: params[:id]).first
		not_found if @customer.nil?
		@customer.increment!(:views)
	end

	def destroy
		@customer = BadCustomer.find(params[:id]).update_attributes(deleted: true)
		redirect_to bad_customers_path
	end

	private
		def bad_customer_params
			params.require(:bad_customer).permit(:name, :cnp, :message)
		end
end
