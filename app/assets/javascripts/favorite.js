$(function(){
  $('.favorite-btn').on('click', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      processData: false,
      contentType: false
    })
  });
});