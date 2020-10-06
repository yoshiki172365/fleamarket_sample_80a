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
|birthday_yyyy_id|integer|null: false|
|birthday_mm_id|integer|null: false|
|birthday_dd_id|integer|null: false|
|phone_number|integer|null: false, unique: true, limit: 11|
|introduction|string|limit: 1000|
|icon_image|string||

### Association
- belongs_to :address
- belongs_to_active_hash :birthday_yyyy
- belongs_to_active_hash :birthday_mm
- belongs_to_active_hash :birthday_dd
- has_many :cards
- has_many :sns_credentials
- has_many :items
- has_many :favorites
- has_many :favorite_items, through: :favorites, source: :item
- has_many :comments
- has_many :user_comments, through: :comments, source: :item
- has_many :purchases

## birthdays_yyyyテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|birthday_yyyy|integer|null: false|

### Association
- has_many :users

## birthdays_mmテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|birthday_mm|integer|null: false|

### Association
- has_many :users

## birthdays_ddテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|birthday_dd|integer|null: false|

### Association
- has_many :users

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|validity_date|date|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|

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
|address1|string|null: false|
|address2|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many_active_hash :prefectures

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

## prefecturesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- belongs_to :item
- belongs_to :address
- belongs_to :purchase

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
- belongs_to_active_hash :prefecture
- has_many :favorites
- has_many :favorite_items, through: :favorites, source: :user
- has_many :comments
- has_many :user_comments, through: :commments, source: :user
- has_many :items_images
- belongs_to_active_hash :category
- belongs_to_active_hash :stats
- belongs_to_active_hash :delivery_charge
- belongs_to_active_hash :delivery_way
- belongs_to_active_hash :size
- belongs_to_active_hash :delivery_date

## categorysテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|name|references|null: false, foreign_key: true|
|ancestry|||

### Association
- belongs_to :item

## statusesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- belongs_to :item

## delivery_chargesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|charge|string|null: false|

### Association
- belongs_to :item

## delivery_ways(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|way|string|null: false|

### Association
- belongs_to :item

## sizesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|size|string|null: false|

### Association
- belongs_to :item

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
- belongs_to_active_hash :payment_way
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :payment_status
- belongs_to_active_hash :shipping_status
- belongs_to_active_hash :delivery_status

## payment_waysテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|way|string|null: false|

### Association
- belongs_to :purchase

## payment_statusesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- belongs_to :purchase

## shipping_statusesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- belongs_to :purchase

## delivery_statusesテーブル(gem 'active_hash')

|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- belongs_to :purchase
