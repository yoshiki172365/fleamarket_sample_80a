require 'rails_helper'

describe Item do
  describe '#create' do
    it "nameが無い場合には出品出来ないこと" do
      item = build(:item, name: nil)
      item.valid?
      expect("商品名を入力してください").to include("商品名を入力してください")
    end

    it "nameが40文字以下であれば出品できること" do
      item = build(:item, name: "高橋酒造")
      item.valid?
      expect(item).to be_valid
    end

    it "nameが41文字以上だと出品出来ないこと" do
      item = build(:item, name: "薩摩酒造"* 41)
      item.valid?
      expect("40文字以下で入力してください").to include("40文字以下で入力してください")
    end

    it "descriptionが無い場合には出品出来ないこと" do
      item = build(:item, description: nil)
      item.valid?
      expect("商品の説明を入力してください").to include("商品の説明を入力してください")
    end

    it "descriptionが1000文字以下の場合には出品出来ること" do
      item = build(:item, description: "二階堂酒造"* 200)
      item.valid?
      expect(item).to be_valid
    end

    it "descriptionが1001文字以上の場合には出品出来ないこと" do
      item = build(:item, description: "霧島酒造"* 251)
      item.valid?
      expect("1000文字以下で入力してください").to include("1000文字以下で入力してください")
    end

    it "category_idが無い場合には出品出来ないこと" do
      item = build(:item, category_id: nil)
      item.valid?
      expect("カテゴリーを選択してください").to include("カテゴリーを選択してください")
    end

    it "brandの項目が入力されていなくても出品出来ること" do
      item = build(:item, brand: nil)
      item.valid?
      expect(item).to be_valid
    end

    it "status_idが無い場合には出品出来ないこと" do
      item = build(:item, status_id: nil)
      item.valid?
      expect("商品の状態を選択してください").to include("商品の状態を選択してください")
    end

    it "deilvery_charge_idが無い場合には出品出来ないこと" do
      item = build(:item, delivery_charge_id: nil)
      item.valid?
      expect("配送料の負担を選択してください").to include("配送料の負担を選択してください")
    end

    it "prefecture_idが無い場合には出品出来ないこと" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect("発送元の地域を選択してください").to include("発送元の地域を選択してください")
    end

    it "delivery_date_idが無い場合には出品出来ないこと" do
      item = build(:item, prefecture_id: nil)
      item.valid?
      expect("発送までの日数を選択してください").to include("発送までの日数を選択してください")
    end

    it "priceが無い場合には出品出来ないこと" do
      item = build(:item, price: nil)
      item.valid?
      expect("300〜9,999,999の間で入力してください").to include("300〜9,999,999の間で入力してください")
    end

    it "画像が無い場合には出品出来ないこと" do
      item = build(:image, image: nil)
      item.valid?
      expect("最低1枚は画像をアップロードしてください").to include("最低1枚は画像をアップロードしてください")
    end
  end


end
