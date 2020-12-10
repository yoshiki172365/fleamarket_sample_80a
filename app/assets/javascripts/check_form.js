// 入力フォームのバリデーション
$(function() {
  let value;
  let next;
  let priceNext;
  let textNext;
  let input_column;
  let cnt;
  const cnt_area_name = $('.now_cnt_name')
  const cnt_area_explanation = $('.now_cnt_explanation')

  // blur時の動作
  function fieldBlur(input) {
    cnt = input.val().length;
    value = input.val();
    next = input.next();
    textNext = input.next().next();
    priceNext = input.parent().parent().next();
    input_column = input.prop('id');
    // 未入力のチェック
    switch (input_column) {
      case "item_name":
        if (value === "") {
          input.addClass('error')
          textNext.remove();
          input.parent().append(`<p class='error'>入力してください</p>`)
        } else if (cnt <= 40) {
          input.removeClass('error')
          textNext.remove();
        }
        break;
      case "item_explanation":
        if (value === "") {
          input.addClass('error')
          textNext.remove();
          input.parent().append(`<p class='error'>入力してください</p>`)
        } else if (cnt <= 1000) {
          input.removeClass('error')
          textNext.remove();
        }
        break;
      case "sell-price-input":
        if (value === "" || value < 300 || value >= 10000000) {
          if (!priceNext.hasClass('error')) {
            input.addClass('error')
            input.parent().parent().after(`<p class='error price-error'>300以上10,000,000未満で入力してください</p>`);
          }
        } else if (priceNext.hasClass('error')) {
          priceNext.remove();
        } else {
          ;
        }
        break;
      case "item_item_images_image":
        break;
      default:
        if (value === "" && !next.hasClass('error')) {
          input.addClass('error')
          if (input.is('select')) {
            input.after(`<p class='error'>選択してください</p>`);
          } else {
            input.after(`<p class='error'>入力してください</p>`)
          }
        } else if (value != "") {
          input.removeClass('error');
          next.remove();
        }
        break;
    }
  }

  // 出品ボタン押下時の処理
  $('.item-form-btn').click(function(e) {
    e.preventDefault();
    const submitID = $(this).attr('id')
    let flag = true;
    const num = $('.item-image').length
    const imageNext = $('#image-box-1').next();

    if (num == 0) {
      flag = false;
      if (!imageNext.hasClass('error')) {
        $('#image-box-1').after(`<p class='error'>画像がありません</p>`);
      }
    } else {
      if (imageNext.hasClass('error')) {
        imageNext.remove();
      }
    }

    $('input:required').each(function(e) {
      if ($('input:required').eq(e).val() === "") {
        fieldBlur($('input:required').eq(e));
        flag = false;
      }
    });
    $('textarea:required').each(function(e) {
      if ($('textarea:required').eq(e).val() === "") {
        fieldBlur($('textarea:required').eq(e));
        flag = false;
      }
    });
    $('select').each(function(e) {
      if ($('select').eq(e).val() === "") {
        fieldBlur($('select').eq(e));
        flag = false;
      }
    });

    if (flag) {
      if (submitID == 'item-post-btn') {
        $("input[name='item[trading_status_id]']").val(1);
        $('#new_item').submit();
        $('.edit_item').submit();
      } else {
        $("input[name='item[trading_status_id]']").val(4);
        $('#new_item').submit();
        $('.edit_item').submit();
      }
    } else {
      $(this).off('submit');
      $('body,html').animate({ scrollTop: 0 }, 500);
      return false;
    }
  });
});
