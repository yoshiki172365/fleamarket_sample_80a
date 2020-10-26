class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :size, :status, :delivery_charge, :delivery_way, :prefecture_id, :delivery_date, :price, images_attributes: [:image_src])
  end
end
