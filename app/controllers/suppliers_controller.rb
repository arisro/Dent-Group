class SuppliersController < ApplicationController
	def index
		@suppliers = Supplier.where(deleted: false, website_country: get_country).order("id").page(params[:page]).per(10)
	end

	def new
		@supplier = Supplier.new
    authorize @supplier
	end

	def create
		@supplier = Supplier.new(supplier_params)
    authorize @supplier
		@supplier.user_id = current_user.id
		@supplier.website_country = get_country
		if @supplier.save
			flash[:success] = "Supplier posted!"
      		redirect_to @supplier
		else
			render 'new'
		end
	end

	def edit
		@supplier = Supplier.where(deleted: false, id: params[:id]).first
		not_found if @supplier.nil?
    authorize @supplier
	end

	def update
		@supplier = Supplier.where(deleted: false, id: params[:id]).first
		not_found if @supplier.nil?
    authorize @supplier
		if @supplier.update_attributes(supplier_params)
			flash[:success] = "Supplier updated!"
      		redirect_to @supplier
		else
			render 'edit'
		end
	end

	def show
		@supplier = Supplier.where(deleted: false, id: params[:id], website_country: get_country).first
		not_found if @supplier.nil?
		@supplier.increment!(:views)
		@comments = @supplier.supplier_comments.where(deleted: false)
		@comment = SupplierComment.new
	end

	def destroy
		@supplier = Supplier.find(params[:id])
    authorize @supplier
    @supplier.update_attributes(deleted: true)
		redirect_to suppliers_path
	end

	private
		def supplier_params
			params.require(:supplier).permit(:name, :description,:email,:phone,:website,:country,:city,:address,:image,:short_description)
		end
end
