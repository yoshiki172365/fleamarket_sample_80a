$(function () {
    let grandchild_category_all_checkbox = $('#grandchildren_category_all');
    let grandchild_category_checkboxes = $('input[name="q[category_id_in][]"]');
    const status_all_checkbox = $('#status_all')
    const status_checkboxes = $('input[name="q[status_id_in][]"]')
    const delivery_charge_all_checkbox = $('#delivery_charge_all')
    const delivery_charge_checkboxes = $('input[name="q[delivery_charge_id_in][]"]')
    const trading_status_all_checkbox = $('#trading_status_all')
    const trading_status_checkboxes = $('input[name="q[trading_status_id_in][]"]')

    //"すべて"をクリックした時に、他のcheckboxも選択されるように
    $(document).on('change', '.js-checkbox-all', function () {
      function targetCheckboxesChange(target, trigger) {
        if (trigger.prop("checked") == true) {
          target.prop("checked", true);
        } else {
          target.prop("checked", false);
        }
      }

      let target_checkboxes;
      switch ($(this).prop('id')) {
        case $('#grandchildren_category_all').prop('id'):
          target_checkboxes = $('input[name="q[category_id_in][]"]');
          break;
        case status_all_checkbox.prop('id'):
          target_checkboxes = status_checkboxes;
          break;
        case delivery_charge_all_checkbox.prop('id'):
            target_checkboxes = delivery_charge_checkboxes;
          break;
        case trading_status_all_checkbox.prop('id'):
          target_checkboxes = trading_status_checkboxes;
          break;
        default:
      }
      targetCheckboxesChange(target_checkboxes, $(this));
    });

    // "すべて"以外をクリックした時の挙動
  $(document).on('change', '.js_search_checkbox > input:checkbox', function () {
    function allCheckboxChange(target, all_checkbox, trigger) {
      if (trigger.prop("checked") == false) { //すべて以外のチェックボックスのチェックが外れている
        all_checkbox.prop("checked", false);// すべてのチェックを外す
      } else {
        let flag = true //フラグを立てる
        target.each(function (e) { //すべて以外のチェックボックスを順番に見ていく
          if (target.eq(e).prop("checked") == false) { //チェックが外れていると
            flag = false; //フラグにfalse
          }
        });
        if (flag) { //"すべて"以外のチェックボックスに、全部チェックボックスが入っている
          all_checkbox.prop("checked", true); //"すべてにチェックを入れる"
        }
      }
    }

    let all_checkbox;
    grandchild_category_all_checkbox = $('#grandchildren_category_all');
    grandchild_category_checkboxes = $('input[name="q[category_id_in][]"]');
    switch ($(this).prop('name')) {
      case grandchild_category_checkboxes.prop('name'):
        target_checkboxes = grandchild_category_checkboxes;
        all_checkbox = grandchild_category_all_checkbox;
        break;
      case status_checkboxes.prop('name'):
        target_checkboxes = status_checkboxes;
        all_checkbox = status_all_checkbox;
        break;
      case delivery_charge_checkboxes.prop('name'):
        target_checkboxes = delivery_charge_checkboxes;
        all_checkbox = delivery_charge_all_checkbox;
        break;
      case trading_status_checkboxes.prop('name'):
        target_checkboxes = trading_status_checkboxes;
        all_checkbox = trading_status_all_checkbox;
        break;
      default:
    }
    allCheckboxChange(target_checkboxes, all_checkbox, $(this));
  });

  // ページを読み込んだ時に、"すべて"のチェックボックスにチェックを入れるかどうか判断
  function loadCheckboxSlection(target, all_checkbox) {
    let flag = true;
    target.each(function(e) {
      if (target.eq(e).prop("checked") == false) {
        flag = false;
      }
    });
    if (flag) {
      all_checkbox.prop("checked", true);
    }
  }

  //ページ読み込み時に、"すべて"のチェックボックスににチェックを入れるか判断する関数
  if ($('#item_search_form').length) {
    loadCheckboxSlection(grandchild_category_checkboxes, grandchild_category_all_checkbox)
    loadCheckboxSlection(status_checkboxes, status_all_checkbox)
    loadCheckboxSlection(delivery_charge_checkboxes, delivery_charge_all_checkbox)
    loadCheckboxSlection(trading_status_checkboxes, trading_status_all_checkbox)
  }
})
