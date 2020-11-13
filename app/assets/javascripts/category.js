$(document).on('turbolinks:load', () => {
  $('.products_new-product_explanation__category--box').on('change', 'select', function () {
    $(this).nextAll('select').remove()
    let id = $(this).get(0).value
    if (id == "") {
      return
    } else {
      $.ajax({
        type: 'GET',
        url: '/categories',
        data: {
          id: id
        },
        dataType: 'json'
      })
        .done(function (categories) {
          if (categories == "") {
            return
          } else {
            $('.products_new-product_explanation__category--box').append(`<select name="item[category_id]"></select>`)
            $('.products_new-product_explanation__category--box > select:last').append(`<option value="">選択してください</option>`);
            categories.forEach(function (category) {
              let html = `<option value=${category.id}>${category.name}</option>`
              $('.products_new-product_explanation__category--box > select:last').append(html);
            });
          }
        })
        .fail(function () {
          alert('error');
        })
    }
  })
})
