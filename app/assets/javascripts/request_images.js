$(function(){
  $('.small-img-style').each(function(){
    $(this).click(function(){
      $('#main_image').attr('src', $(this).attr('src'));
      $('.small-img-style').css('border-width', '0px');
      $(this).css('border-color', 'red');
      $(this).css('border-style', 'solid');
      $(this).css('border-width', '1px');
    });
  });
});
