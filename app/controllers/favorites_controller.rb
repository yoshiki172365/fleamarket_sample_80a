class FavoritesController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!

  def create
    # 出品者も自分の商品にお気に入り出来るように一旦コメントアウト
    # if @item.user_id != current_user.id
        @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
    # end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id: @item.id)
    @favorite.destroy
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

end
