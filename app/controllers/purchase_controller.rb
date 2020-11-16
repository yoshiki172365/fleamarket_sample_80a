class PurchaseController < ApplicationController

  require 'payjp'
  before_action :set_card, only: [:index, :pay]
  before_action :set_item, only: [:index, :pay, :done]

  def index #テーブルからpayjpの顧客IDを検索
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path, alert: "クレジットカード情報を登録してください"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end

    @address = Address.find_by(user_id: current_user.id)
  end

  def pay
    @purchase = Purchase.new
    @purchase.item_id = @item.id
    @purchase.user_id = current_user.id
    @purchase.save
    @item.trading_status = 2
    @item.save

    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    Payjp::Charge.create(
      amount: @item.price, #支払金額を入力（あとからitemに紐づける）
      customer: @card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )
    redirect_to action: 'done' #完了画面に移動
  end


  def done
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
