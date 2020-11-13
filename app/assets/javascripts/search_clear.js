$(function () {
  $('#js_search_clear').on('click', function () {
    clearForm(this.form);
  });

    function clearForm(form) {
      $(form).find("input, select").not(":button, :submit, :reset, :hidden")
        .val("").prop("checke", false).prop("checked", false);

      $('select[name=sort_order').childeren().first().attr('selected', true);
      $('children_category_search').remove();
      $('grandchildren_category_checkboxes').remove();
    }
});
