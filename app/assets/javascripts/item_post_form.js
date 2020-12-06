$(document).on('turbolinks:load', () => {
  $('.input-area').focus();

  let imageNext;
  let fileIndex = 0;
  // 画像プレビュー関数
  function imagePreview(src, filename, i, num) {
    const html= `
      <div class='item-image add-image' data-image="${filename}" data-index-delete="${i}">
        <div class='item-image__content'>
          <div class='item-image__content--icon'>
            <img src=${src} width="114" height="80" index="${i}">
          </div>
        </div>
        <div class='item-image__operation'>
          <div class='item-image__operation--delete'>削除</div>
        </div>
      </div>
      `
    $('#image-box__container').before(html);
    $('#image-box__container').attr('class', `item-num-${num} drag-area`)
  }

  // 画像追加時のエラーチェック関数
  function errorCheckOnAdd() {
    imageNext = $('#image-box-1').next();
    if (imageNext.hasClass('error')) {
      imageNext.remove();
    }
  }
  // 画像削除時のエラーチェック動作
  function errorCheckOnDel(num) {
    imageNext = $('#image-box-1').next();
    if (num == 0) {
      if (!imageNext.hasClass('error')) {
        $('#image-box-1').after(`<p class='error'>画像がありません</p>`);
      }
    }
  }

  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  const file_field = document.querySelector('input[type=file]')

  //fileが選択された時に発火するイベント
  $(document).on('change', '.img-file', function() {
    errorCheckOnAdd();

    //選択したfileのオブジェクトをpropで取得
    const files = $('input[type="file"]').prop('files')[0];
    const currentNum = $('.item-image').length
    const add_files_length = this.files.length
    const inputNum = currentNum + add_files_length

    $.each(this.files, function (i, file) {
      const fileReader = new FileReader();
      fileReader.readAsDataURL(file);
      const num = i

      //画像が10枚になったら超えたらドロップボックスを削除する
      if (currentNum + i + 1 >= 10) {
        $('#image-box__container').css('display', 'none')
        fileReader.onloadend = function() {
          fileIndex += 1;
          const src = fileReader.result
          imagePreview(src, file.name, fileIndex, inputNum)
          dataBox.items.add(file)
          dataBox.items.remove(dataBox.items.length - 1);
          file_field.files = dataBox.files
        };
        return false;
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        fileIndex += 1;
        const src = fileReader.result
        imagePreview(src, file.name, fileIndex, inputNum)
        dataBox.items.add(file)
        $('input[type="file"]').val('');
        file_field.files = dataBox.files
      };
    });
  });

  // 画像ドラック時の動作
  $(window).on('load', function (e) {
    const dropArea = document.getElementById("image-box-1");

    if (dropArea) {
      //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
      dropArea.addEventListener("dragover", function (e) {
        e.preventDefault();
        //ドロップエリアに影がつく
        $(this).children('.drag-area').css({ 'border': '1px solid rgb(204, 204, 204)', 'box-shadow': '0px 0px 4px' })
      }, false);

      //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
      dropArea.addEventListener("dragleave", function (e) {
        e.preventDefault();
        //ドロップエリアの影が消える
        $(this).children('.drag-area').css({ 'border': 'none', 'box-shadow': '0px 0px 0px' })
      }, false);

      //ドラッグした要素をドロップした時に発火するイベント
      dropArea.addEventListener("drop", function (e) {

        e.preventDefault();
        $(this).children('.drag-area').css({ 'border': 'none', 'box-shadow': '0px 0px 0px' });

        errorCheckOnAdd();

        const files = e.dataTransfer.files;
        const add_files_length = files.length;

        //ドラッグアンドドロップで取得したデータについて、プレビューを表示
        $.each(files, function (i, file) {
          const fileReader = new FileReader();
          fileReader.readAsDataURL(file);
          const currentNum = $('.item-image').length
          const inputNum = currentNum + add_files_length
          const num = i
          if (currentNum + i + 1 >= 10) {
            $('#image-box__container').css('display', 'none')
            fileReader.onloadend = function () {
              fileIndex += 1;
              const src = fileReader.result
              imagePreview(src, file.name, fileIndex, inputNum)
              dataBox.items.add(file)
              file_field.files = dataBox.files
            };
            return false;
          }
          //image fileがロードされた時に発火するイベント
          fileReader.onloadend = function () {
            fileIndex += 1;
            const src = fileReader.result
            imagePreview(src, file.name, fileIndex, inputNum)
            dataBox.items.add(file)
            file_field.files = dataBox.files
          };
        })
      })
    }
  });
  //削除ボタンをクリック時の動作
  $(document).on("click", '.item-image__operation--delete', function () {
    //削除を押されたプレビュー要素を取得
    const target_image = $(this).parent().parent()
    //削除を押されたプレビューimageのindexを取得
    const targetIndex = $(target_image).data('index')
    const deleteIndex = $(target_image).data('index-delete') - 1;
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    const addImages = $('.add-image');
    let index = 0;
    if (addImages.length == 1) {
      //inputタグに入ったファイルを削除
      $('input[type=file]').val(null)
      dataBox.clearData();
    } else {
      //プレビューが複数の場合
      $.each(addImages, function (i, input) {
        //削除を押されたindexと一致した時、index番号に基づいてdataBoxに格納された要素を削除する
        if (i == deleteIndex) {
          dataBox.items.remove(deleteIndex)
        } else {
          index += 1
          $(input).attr('data-index-delete', index);
        }
      })
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
      file_field.files = dataBox.files
    }
    //プレビューを削除
    target_image.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    const num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num} drag-area`)

    errorCheckOnDel(num);
  });


  // $('.products_new-product__submit--btn').click(function (e) {
  //   // e.preventDefault();
  //   const num = $('.item-image').length
  //   const imageNext = $('#image-box-1').next();

  //   if (num == 0) {
  //     if (!imageNext.hasClass('error')) {
  //       alert("画像は最低1枚アップロードしてください")
  //       $('.products_new-product__submit--btn').prop("disalbed", false)
  //     } else {
  //     if (imageNext.hasClass('error')) {
  //       imageNext.remove();
  //     }
  //   }
  //   }
  // })
});
