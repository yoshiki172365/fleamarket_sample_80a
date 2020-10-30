$(function () {
  $('#new_product').validate({
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
        required: true,
      },
      "item[status]": {
        required: true,
      },
      "item[delivery_charge]": {
        required: true,
      },
      "item[prefecture_id]": {
        required: true,
      },
      "item[delivery_date]": {
        required: true,
      },
      "item[price]": {
        required: true,
      },
      previews: {

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
      "item[status]": {
        required: "商品の状態を選択してください",
      },
      "item[delivery_charge]": {
        required: "配送料の負担を選択してください",
      },
      "item[prefecture_id]": {
        required: "発送元の地域を選択してください",
      },
      "item[delivery_date]": {
        required: "発送までの日数を選択してください",
      },
      "item[price]": {
        required: "300〜9,999,999の間で入力してください",
      },
      previews: {

      }
    },
    errorPlacement: function(error, element) {

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

        case "item[status]":
          error.insertAfter('#required_error_status');
          break;

        case "item[delivery_charge]":
          error.insertAfter('#required_error_delivery_charge');
          break;

        case "item[prefecture_id]":
          error.insertAfter('#required_error_prefecture_id');
          break;

        case "item[delivery_date]":
          error.insertAfter('#required_error_delivery_date');
          break;

        case "item[price]":
          error.insertAfter('#required_error_price');
          break;

        case previews:
          error.insertAfter('#previews');
          break;
      }
    }
  });
});
