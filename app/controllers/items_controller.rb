class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_parents, only: [:index, :new, :create, :show, :search]
  before_action :set_item_search_query

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
      logger.debug @item.errors.inspect
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
    @search_parents = Category.where(ancestry: nil).pluck(:name)

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

    # if category_key = params.require(:q)[:category_id]
    #   if category_key.to_i == 0
    #     @search_category = Category.find_by(name: category_key, ancestry: nil)
    #   else
    #     @search_category = Category.find(category_key)
    #   end
    # end


  end

  #ajax通信でデータ取得のためのメソッド
  def price_range
    if params[:price_id].nil?
      @price_range = PriceRange.find(params[:min], params[:max])
    else
      @price_range = PriceRange.find(params[:price_id])
    end
  end

  #親カテゴリが選択された後に動くアクション
  def category_children
    #選択された親カテゴリに紐づく子供カテゴリの配列を取得
    @children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def category_grandchildren
    #選択された子供カテゴリに紐づく子供カテゴリの配列を取得
    @grandchildren = Category.find("#{params[:child_id]}").children
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
    params.require(:q).permit(:sorts,
      #親カテゴリのみ、子供カテゴリまでの検索を拾う
      :category_id,
      :price_gteq,
      :price_lteq,
      #複数条件の検索を拾う
      category_id_in: [],
      status_id_in: [],
      delivery_charge_id_in: [],
      trading_status_id_in: []
    )
  end

end
