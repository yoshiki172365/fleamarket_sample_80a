$(function () {
  const min_price = $('#q_price_gteq')
  const max_price = $('#q_price_lteq')

  $('#price_range').on('change', function() {
    const price_range = $(this).val();
    if (price_range != "") {
      $.ajax({
        url: '/items/price_range',
        type: 'GET',
        data: { price_id: price_range},
        dataType: 'json'
      })
      .done(function(range) {
        min_price.val(range.min);
        max_price.val(range.max);
      })
      .fail(function() {
        alert('価格帯の取得に失敗しました')
      })
    } else {
      min_price.val('');
      max_price.val('');
    }

  });
});
