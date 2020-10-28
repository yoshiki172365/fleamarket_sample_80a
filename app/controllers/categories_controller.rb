class CategoriesController < ApplicationController

  def index
    @category = Category.find(params[:id]).children
      respond_to do |format|
        format.json { render json:@category}
      end
  end
end
