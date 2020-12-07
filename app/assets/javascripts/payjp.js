$(function(){
  Payjp.setPublicKey ('pk_test_86c115def9e13cbe14f31065')
  var submit = document.getElementById("token_submit");
  submit.addEventListener('click', function(e){
    e.preventDefault();
    var card = {
      number: document.getElementById("card_number").value,
      exp_year: document.getElementById("exp_year").value,
      exp_month: document.getElementById("exp_month").value,
      cvc: document.getElementById("cvc").value
    };

    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        $("#card_token").append(
          $('<input type="hidden" name="token">').val(response.id)
        );
        document.inputForm.submit();
        alert("登録が完了しました");
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
});

// document.addEventListener(
//   "DOMContentLoaded", (e) => {
//     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_86c115def9e13cbe14f31065"); //ここに公開鍵を直書きする
//       const btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
//       btn.addEventListener("click", (e) => { //ボタンが押されたときに作動します
//         e.preventDefault(); //ボタンを一旦無効化
//         const card = {  // 入力されたデータを取得
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         };

//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) { //成功した場合
//             const token = response.id; //レスポンスの中のidにトークンがあるので取り出す
//             const renderDom = document.getElementById("charge-form");//フォームを取得後、変数代入
//             //下記のinputタグを変数に代入
//             const tokenObj = `<input value=${token} type="hidden" name="token">`
//             renderDom.insertAdjacentHTML("beforeend", tokenObj);//最後より手前にフォームにtokenObj代入

//             //自分のサーバーに送信しちゃマズいもの削除
//             document.getElementById("card_number").removeAttribute("name");
//             document.getElementById("cvc").removeAttribute("name");
//             document.getElementById("exp_month").removeAttribute("name");
//             document.getElementById("exp_year").removeAttribute("name");
//             //サーバーに必要なものだけ送信、フォームを空にする
//             document.getElementById("charge-form").submit();
//             document.getElementById("charge-form").reset();

//             alert("登録が完了しました"); //確認用
//           } else {
//             alert("カード情報が正しくありません。"); //確認用
//           }
//         });
//       });
//     }
//   },
//   false
// );
