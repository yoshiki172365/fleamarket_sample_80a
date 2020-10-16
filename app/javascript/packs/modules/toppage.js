$(function(){
  $(".Header__inner__nav__left__category").on('mouseover', function(){
    $("Header__inner__nav__left__category__tree").slideDown();
    console.log("#")
  });
  $(".Header__inner__nav__left__category").on('mouseleave', function(){
    $(".Header__inner__nav__left__category__tree").slideUp();
  });
});

