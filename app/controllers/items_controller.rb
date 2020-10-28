class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show]
  
  def index

  end

  def edit
  end

  def show
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
