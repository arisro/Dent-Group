ActiveAdmin.register Supplier do
  controller do
    def show
        @supplier = Supplier.find(params[:id])
        @versions = @supplier.versions 
        @supplier = @supplier.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show
  
end
