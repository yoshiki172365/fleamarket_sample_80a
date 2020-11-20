class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_parents, only: [:index, :new, :create, :show, :search, :search_index]

  before_action :set_item_search_query, except: [:result]

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
    @categories = Category.where(ancestry: nil)
    @user = User.find(@item.user_id)
  end

  def edit
    @categories = Category.where(ancestry: nil)

    grandchild_category = @item.category
    child_category = grandchild_category.parent

    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    @category_children_array = Category.where(ancestry: child_category.ancestry)
    @category_grandchildren_array = Category.where(ancestry: grandchild_category.ancestry)
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
    render  action: :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id && @item.destroy
      redirect_to root_path, notice: "削除しました"
    else
      render :show
    end
  end

  def search

  end

  def result
    # @q = Item.includes(:images).search(search_params)
    # sort = params[:sort] || "created_at DESC"
    # # jsから飛んできたパラーメーターが"likes_count_desc"の場合に、子モデルの多い順にソートする記述を
    # if sort == "likes_count_desc"
    #   @items = @q.result(distinct: true).select('items.*', 'count(likes.id) AS likes')
    #     .left_joins(:likes)
    #     .group('items.id')
    #     .order('likes DESC').order('created_at DESC')
    # else
    #   @items = @q.result(distinct: true).order(sort)
    # end

    if params[:q].present?
    # 検索フォームからアクセスした時の処理
      @search = Item.ransack(search_params)
      @items = @search.result
    else
    # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @search = Item.ransack()
      @items = Item.all
    end
  end


  def search_index
    if params[:q].present?
    # 検索フォームからアクセスした時の処理
      @search = Item.ransack(search_params)
      @items = @search.result
    else
    # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @search = Item.ransack()
      @items = Item.all
    end
  end

  #ajax通信でデータ取得のためのメソッド
  def price_range
    if params[:price_id].nil?
      @price_range = PriceRange.find(params[:min], params[:max])
    else
      @price_range = PriceRange.find(params[:price_id])
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
                  [:src, :_destroy, :id]).merge(user_id: current_user.id, trading_status_id: 1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def search_params
    params.require(:q).permit!
  end

end
