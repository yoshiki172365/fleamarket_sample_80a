$(document).on('turbolinks:load', () => {
  //プルダウン選択後にイベント発生
  $('select[name=sort_order]').change(function () {
    const sort_order = $(this).val();  //選択したoptionタグのvalue属性を取得する

    //value属性の値によりページ遷移先を分岐する
    switch (sort_order) {
      case 'price-asc': html = "&sort=price+asc"; break;
      case 'price-desc': html = "&sort=price+desc"; break;
      case 'created_at-desc': html = "&sort=created_at+desc"; break;
      case 'likes-desc': html = "&sort=likes_count_desc"; break;
      default: html = "&sort=created_at+desc";
    }

    //現在の表示ページ
    let current_html = window.location.href;
    //ソート機能の重複帽子
    if (location['href'].match(/&sort=*.+/) != null) {
      var remove = location['href'].match(/&sort=*.+/)[0]
      current_html = current_html.replace(remove, '')
    };
    //ページを遷移させる
    window.location.href = current_html + html
  });
  //ページ遷移後の挙動
  $(function () {
    if (location['href'].match(/&sort=*.+/) != null) {
      // option[selected: 'selected']を削除
      if ($('select option[selected=selected]')) {
        $('select option:first').prop('selected', false);
      }

      const selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');

      switch (selected_option) {
        case "price+asc": var sort = 1; break;
        case "price+desc": var sort = 2; break;
        case "created_at+desc": var sort = 3; break;
        case "likes_count_desc": var sort = 4; break;
        default: var sort = 0
      }
      const add_selected = $('select[name=sort_order]').children()[sort]
      $(add_selected).attr('selected', true)
    }
  });
});
