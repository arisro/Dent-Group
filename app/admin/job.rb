ActiveAdmin.register Job do
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
