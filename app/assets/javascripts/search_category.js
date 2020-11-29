$(document).on('turbolinks:load', () => {

  function appendOption(category) { //optionの作成 ディベロッパーツールで親のoption参考
    let html = `<option value="${category.id}">${category.name}</option>`;
    return html
  }

  function appendChildrenBox(insertHTML) { //子供カテゴリセレクトボックス作成 ここも親カテゴリを参照して作成
    const childSelectHTML = `<select id="child_category_search" name="q[category_id]">
                            <option value="">選択してください</option>
                            ${insertHTML}
                          </select>`
    $('.items-search-category-form').append(childSelectHTML); //classの中に加える
  }

  function appendCheckbox(category) { //孫カテゴリのcheckboxとラベル
    let html = `<div class="grandchild-search-category-checkbox__list">
                  <div class="grandchild-search-category-checkbox__btn js_search_checkbox">
                    <input type="checkbox" value="${category.id}" name="q[category_id_in][]" id="q_category_id_in_${category.id}">
                  </div>
                  <div class="grandchild-checkbox-label">
                    <label for="q_grandchild_category_id_in_${category.id}">${category.name}</label>
                  </div>
                </div>`
    return html;
  }

  function appendGrandchildrenBox(insertHTML) { //"すべて"のcheckboxとラベル  そこへinsertHTMLを差し込む
    const grandchildselectHTML = `<div id="grandchildren_category_checkboxes" class="grandchildren-checkbox__lists">
                                    <div class="search-form-grandChild-checkbox js_search_checkbox">
                                      <div class="grandchild-category-checkbox-btn">
                                        <input type="checkbox" class="js-checkbox-all" id="grandchildren_category_all">
                                      </div>
                                      <div class="grandchild-checkbox-label">
                                        <label for="grandchild_category_all">すべて</label>
                                      </div>
                                    </div>
                                    ${insertHTML}
                                  </div>`;
    $('.items-search-category-form').append(grandchildselectHTML);
  }

  $('#parent_category_search').on('change', function () {
    //選択されたカテゴリを取得する
    const parentName = $(this).val();
    //親カテゴリが初期値で無いことを確認
    if (parentName != "") {
      $.ajax({
        url: '/items/category_children',
        type: 'GET',
        data: { parent_name: parentName },
        dataType: 'json'
      })
        .done(function (children) { //帰ってきたdataをchildrenへ
          //親が変更された時に、子供以下を削除する。削除しないとセレクトボックスが親カテゴリを変更するたびにどんどん追加されるため。
          $('#child_category_search').remove();
          //孫カテゴリの削除を記述
          $('#grandchildren_category_checkboxes').remove();
          let insertHTML = '';
          children.forEach(function (child) {
            //forEachでchildに一つずつ代入し、子供のoptionを一つずつ作成
            insertHTML += appendOption(child);
          });
          appendChildrenBox(insertHTML);
        })
        .fail(function () {
          alert('カテゴリ取得に失敗しました')
        })
    } else { //親カテゴリが初期設定に変更されたら、子ども以下カテゴリ削除
      $('#child_category_search').remove();
      //孫カテゴリの削除を記述する
      $('#grandchildren_category_checkboxes').remove();
    }
  });

  //子供カテゴリ選択時 セレクトボックスのクラスに対して、onでイベントを拾う
  $('.items-search-category-form').on('change', '#child_category_search', function() {
    const childId = $(this).val();
    //選択された子供カテゴリのidを取得
    if (childId != "") {
      //子供カテゴリーが初期値で無いことを確認
      $.ajax({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren) {
        //子供が変更されたら孫以下を削除する
        $('#grandchildren_category_checkboxes').remove();
        let insertHTML = '';
        grandchildren.forEach(function (grandchild) {
          insertHTML += appendCheckbox(grandchild);
        });
        appendGrandchildrenBox(insertHTML);
      })
      .fail(function() {
        alert('カテゴリ取得に失敗しました');
      })
    } else {
      //孫カテゴリの削除を記述する
      $('#grandchildren_category_checkboxes').remove();
    }
  })
});
