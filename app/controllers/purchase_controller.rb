class PurchaseController < ApplicationController

  require 'payjp'

  def index #テーブルからpayjpの顧客IDを検索
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path, alert: "クレジットカード情報を登録してください"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: 1111, #支払金額を入力（あとからitemに紐づける）
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )
    redirect_to action: 'done' #完了画面に移動
  end


  def done
  end

  end
