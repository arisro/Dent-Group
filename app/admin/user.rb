ActiveAdmin.register User do
  controller do
    def show
        @user = User.find(params[:id])
        @versions = @user.versions 
        @user = @user.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show
  
end
