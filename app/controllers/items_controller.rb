class ItemsController < ApplicationController

  before_action :set_item, except: [:index, :new, :create, :show]
  before_action :set_parents, only: [:new, :create]

  def index
  end

  def show
    @user = User.find(1)
    @item = Item.find(0)
    @image = Image.find(1)
    @categories = Category.where(ancestry: nil)
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
          .permit(:name,
                  :description,
                  :brand,
                  :category_id,
                  :status_id,
                  :delivery_charge_id,
                  :prefecture_id,
                  :delivery_date_id,
                  :price, images_attributes:
                  [:src, :_destroy, :id]).merge(trading_status: 1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
