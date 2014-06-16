class NewsCategoriesController < ApplicationController
  respond_to :json

  def index
    categories = NewsCategory.joins("LEFT JOIN news ON news_categories.id = news.news_category_id").select("news_categories.*, count(news.id) as news_count").group("news_categories.id").where(deleted: false).order(ident: :asc)
    authorize categories
    respond_with(categories) do |format|
      format.json { render json: categories.as_json }
      format.html
    end
  end

  def create
    new_cat = NewsCategory.new
    authorize new_cat
    new_cat.ident = params[:ident]
    if new_cat.valid?
      new_cat.save!
    else
      respond_with do |format|
        format.json { render nothing: true, status: :unprocessable_entity  }
      end
      return
    end

    respond_with(new_cat) do |format|
      format.json { render :json => new_cat.as_json  }
    end
  end

  def update
    cat = NewsCategory.where(deleted: false, id: params[:id]).first
    not_found if cat.nil?
    authorize cat
    if cat.update_attributes(ident: params[:ident])
      respond_with do |format|
        format.json { render json: cat.as_json }
      end
    else
      respond_with do |format|
        format.json { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cat = NewsCategory.find(params[:id])
    authorize @cat
    @cat.update_attributes(deleted: true)
    respond_with do |format|
      format.json { render nothing: true, status: :ok }
    end
  end

  private
    def categories_params
      params.require(:news_category).permit(:ident)
    end
end
