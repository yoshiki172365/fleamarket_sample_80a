require 'rails_helper'

describe Card do
  describe '#pay' do
    it "user_id, customer_id, card_idが存在すれば登録出来ること" do
      card = build(:card)
      expect(card).to be_valid
    end
  end

    it "user_idがない場合は登録できないこと" do
      card = build(:card, user_id: "")
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end

    it "customer_idが無い場合は登録できないこと" do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idが無い場合は登録できないこと" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

end
