ActiveAdmin.register Job do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  controller do
    def show
        @job = Job.find(params[:id])
        @versions = @job.versions 
        @job = @job.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @job = Job.find(params[:id])
    @versions = @job.versions
    render "layouts/history"
  end
  
end
