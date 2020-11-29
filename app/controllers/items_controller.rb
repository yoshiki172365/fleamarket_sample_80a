class ItemsController < ApplicationController

  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_item, except: [:index, :new, :create, :show]
  before_action :set_parents, only: [:index, :new, :create, :show]

  def index
    @items = Item.all
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

  def show
    @item = Item.find(params[:id])
    @image = @item.images
    @categories = Category.where(ancestry: nil)
    @user = User.find(@item.user_id)
    @comment = Comment.new
    @commentALL = @item.comments
  end

  def edit
  end

  def update
  end

  def destroy
    if current_user.id == @item.user_id && @item.destroy
      redirect_to root_path, notice: "削除しました"
    else
      render :show
    end
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
                  :price,
                  :brand,
                  images_attributes:
                  [:src, :_destroy, :id]).merge(user_id: current_user.id, trading_status: 1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
