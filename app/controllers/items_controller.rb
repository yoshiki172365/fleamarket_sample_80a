class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_parents, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
    @categories = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item.images.new
      @categories = Category.where(ancestry: nil)
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
    params.require(:item)
          .permit(:name, :description, :brand, :category_id, :status, :delivery_charge, :prefecture_id, :delivery_date, :price, images_attributes: [:src, :_destroy, :id]).merge(trading_status: 1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
