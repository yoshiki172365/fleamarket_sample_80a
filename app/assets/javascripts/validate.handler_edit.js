$(document).on('turbolinks:load', () => {
    $('#edit_product').validate({
      rules: {
        "item[name]": {
          required: true,
          maxlength: 40
        },
        "item[description]": {
          required: true,
          maxlength: 1000
        },
        "item[category_id]": {
          required: true
        },
        "item[status_id]": {
          min: 1
        },
        "item[delivery_charge_id]": {
          min: 1
        },
        "item[prefecture_id]": {
          min: 1
        },
        "item[delivery_date_id]": {
          min: 1
        },
        "item[price]": {
          required: true
        }
      },
      messages: {
        "item[name]": {
          required: "商品名を入力してください",
          maxlength: "40文字以下で入力してください"
        },
        "item[description]": {
          required: "商品の説明を入力してください",
          maxlength: "1000文字以下で入力してください"
        },
        "item[category_id]": {
          required: "カテゴリーを選択してください",
        },
        "item[status_id]": {
          min: "商品の状態を選択してください",
        },
        "item[delivery_charge_id]": {
          min: "配送料の負担を選択してください",
        },
        "item[prefecture_id]": {
          min: "発送元の地域を選択してください",
        },
        "item[delivery_date_id]": {
          min: "発送までの日数を選択してください",
        },
        "item[price]": {
          required: "300〜9,999,999の間で入力してください",
        },
        "item[images_attributes][0][src]": {
          required: "最低1枚は画像をアップロードしてください"
        }
      },
      errorPlacement: function (error, element) {
  
        const elAttName = element.attr("name")
        switch (elAttName) {
          case "item[name]":
            error.insertAfter('#required_error_name');
            break;
  
          case "item[description]":
            error.insertAfter('#required_error_description');
            break;
  
          case "item[category_id]":
            error.insertAfter('#required_error_category_id');
            break;
  
          case "item[status_id]":
            error.insertAfter('#required_error_status');
            break;
  
          case "item[delivery_charge_id]":
            error.insertAfter('#required_error_delivery_charge');
            break;
  
          case "item[prefecture_id]":
            error.insertAfter('#required_error_prefecture_id');
            break;
  
          case "item[delivery_date_id]":
            error.insertAfter('#required_error_delivery_date');
            break;
  
          case "item[price]":
            error.insertAfter('#required_error_price');
            break;
  
          case "item[images_attributes][0][src]":
            error.insertAfter('#required_error_image');
            break;
        }
      }
    });
  });
  