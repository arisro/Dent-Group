class JobsController < ApplicationController	
	def index
		@jobs = Job.where(deleted: false, website_country: get_country).order("id").page(params[:page]).per(10)
	end

	def new
		@job = Job.new
	end

	def create
		@job = Job.new(job_params)
		@job.user_id = current_user.id
		@job.website_country = get_country
		if @job.save
			flash[:success] = "Job announcement posted!"
      		redirect_to @job
		else
			render 'new'
		end
	end

	def edit
		@job = Job.where(deleted: false, id: params[:id]).first
		not_found if @job.nil?
	end

	def update
		@job = Job.where(deleted: false, id: params[:id]).first
		not_found if @job.nil?
		if @job.update_attributes(job_params)
			flash[:success] = "Job announcement updated!"
      		redirect_to @job
		else
			render 'edit'
		end
	end

	def show
		# @job = Job.where(deleted: false, id: params[:id], website_country: get_country).first
		@job = Job.where(deleted: false, id: params[:id]).first
		not_found if @job.nil?
		@job.increment!(:views)
	end

	def destroy
		@job = Job.find(params[:id]).update_attributes(deleted: true)
		redirect_to jobs_path
	end

	private
		def job_params
			params.require(:job).permit(:company_name, :title, :description, :country, :city, :type, :count, :offer, :valid_until, :contact_email, :contact_phone, :image)
		end
end
