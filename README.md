## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|phone_number|integer|null: false, unique: true, limit: 11|
|introduction|string|limit: 1000|
|icon_image|string||

### Association
- has_one :address
- has_one :card
- has_many :sns_credentials
- has_many :items
- has_many :favorites
- has_many :comments
- has_many :purchases

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|customer_id|string|null: false|

### Association
- belongs_to :user

## sns_credentialsテーブル

|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|zip_code|string|null: false|
|prefecture_id|references|null: false, foreign_key: true|
|city|string|null: false|
|block_number|string|null: false|
|apartment_name|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## favorite(favorite_items)テーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## commetns(user_commmetns)テーブル

|Column|Type|Options|
|------|----|-------|
|content|string|null: false|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, limit: 40, add_index: true|
|description|string|null: false, limit: 1000|
|category_id|references|null: false, foreign_key: true|
|size_id|integer|null: false|
|brand|string||
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|delivery_way_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_date_id|integer|null: false|
|price|integer|null: false|
|buyer_id|integer|foreign_key: true|
|seller_id|integer|null:false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :purchase
- has_many :favorites
- has_many :comments
- has_many :items_images

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

### Association
- has_many :items

## item_imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image_src|string|null: false|
|item_id|references|null: false, foreign_key: true|

### Association
- belongs_to :item

## purchasesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
|paymet_way_id|integer|null: false|
|prefecture_id|integer|null: false|
|paymet_status_id|integer|null: false|
|shipping_status_id|integer|null: false|
|delivery_status_id|integer|null: false|

### Association
- belongs_to :item
- belongs_to :user
