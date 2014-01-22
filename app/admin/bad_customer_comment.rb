ActiveAdmin.register BadCustomerComment do
  controller do
    def show
        @comment = BadCustomerComment.find(params[:id])
        @versions = @comment.versions 
        @comment = @comment.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show
  
end
