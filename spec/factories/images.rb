FactoryBot.define do
  factory :images do
    image {File.open("#{Rails.root}/public/images/test_image.png")}
  end
end
