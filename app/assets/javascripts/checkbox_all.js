$(document).on('turbolinks:load', () => {
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
        default: ;
      }
      targetCheckboxesChange(target_checkboxes, $(this));
    });


  })
