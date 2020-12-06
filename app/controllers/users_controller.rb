class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @items = @user.items

    favorites = Favorite.where(user_id: current_user.id).pluck(:item_id)
    @favorite_list = Item.find(favorites)
  end

  def privacy
  end

end
