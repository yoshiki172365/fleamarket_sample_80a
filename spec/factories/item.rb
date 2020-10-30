FactoryBot.define do

  factory :item do
    name                {"白岳しろ"}
    description         {"高橋酒造で製造されています"}
    category_id         {create(:category).id}
    brand               {"高橋酒造"}
    status_id           {1}
    delivery_charge_id  {1}
    prefecture_id       {43}
    delivery_date_id    {1}
    price               {3000}
    after(:build) do |item|
      item.images << build(:image)
    end
  end

end
