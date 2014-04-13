class OffersController < ApplicationController
	def index
		type_conditions = {}
		type_conditions[:type] = params[:type] unless params[:type].nil?
		@offers = Offer.where(deleted: false, website_country: get_country).where(type_conditions).order("id").page(params[:page]).per(10)
	end

	def new
		@offer = Offer.new
	end

	def create
		@offer = Offer.new(offer_params)
		@offer.user_id = current_user.id
		@offer.website_country = get_country
		if @offer.save
			flash[:success] = "Offer announcement posted!"
      		redirect_to @offer
		else
			render 'new'
		end
	end

	def edit
		@offer = Offer.where(deleted: false, id: params[:id]).first
		not_found if @offer.nil?
	end

	def update
		@offer = Offer.where(deleted: false, id: params[:id]).first
		not_found if @offer.nil?
		if @offer.update_attributes(offer_params)
			flash[:success] = "Offer announcement updated!"
      		redirect_to @offer
		else
			render 'edit'
		end
	end

	def show
		@offer = Offer.where(deleted: false, id: params[:id], website_country: get_country).first
		not_found if @offer.nil?
		@offer.increment!(:views)
	end

	def destroy
		@offer = Offer.find(params[:id]).update_attributes(deleted: true)
		redirect_to jobs_path
	end

	private
		def offer_params
			params.require(:offer).permit(:title, :body, :type, :summary, :contact_phone, :contact_email)
		end
end
