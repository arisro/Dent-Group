ActiveAdmin.register Offer do
  controller do
    def show
        @offer = Offer.find(params[:id])
        @versions = @offer.versions 
        @offer = @offer.versions[params[:version].to_i].reify if params[:version]
        show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show
end
