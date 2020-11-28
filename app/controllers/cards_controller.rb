class CardsController < ApplicationController

  require "payjp"
  before_action :set_card, only: [:delete, :show]

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end

  def pay #payjpとCardのデータベース作成を実施
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    if params['token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      # description: '登録テスト',
      # email: current_user.email,
      card: params['token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れました
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除
    if @card.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      flash[:alert] = "登録カード情報を削除しました"
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)

      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "mastercard.png"
      when "American Express"
        @card_src = "americanExpress.png"
      when "Diners Club"
        @card_src = "diners.png"
      end
    end
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end
end
