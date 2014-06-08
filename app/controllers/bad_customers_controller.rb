class BadCustomersController < ApplicationController	
	def index
		@customers = BadCustomer.where(deleted: false, website_country: get_country).order("id").page(params[:page]).per(10)
	end

	def new
		@customer = BadCustomer.new
    authorize @customer
	end

	def create
		@customer = BadCustomer.new(bad_customer_params)
    authorize @customer
		@customer.user_id = current_user.id
		@customer.website_country = get_country
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
    authorize @customer
	end

	def update
		@customer = BadCustomer.where(deleted: false, id: params[:id]).first
		not_found if @customer.nil?
    authorize @customer
		if @customer.update_attributes(bad_customer_params)
			flash[:success] = "Customer report updated!"
      		redirect_to @customer
		else
			render 'edit'
		end
	end

	def show
		@customer = BadCustomer.where(deleted: false, id: params[:id], website_country: get_country).first
		not_found if @customer.nil?
		@customer.increment!(:views)
		@comments = @customer.bad_customer_comments.where(deleted: false)
		@comment = BadCustomerComment.new
	end

	def destroy
		@customer = BadCustomer.find(params[:id])
    authorize @customer
    @customer.update_attributes(deleted: true)
		redirect_to bad_customers_path
	end

	private
		def bad_customer_params
			params.require(:bad_customer).permit(:name, :cnp, :message)
		end
end
