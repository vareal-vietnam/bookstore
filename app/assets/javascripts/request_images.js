$(function(){
  $('.small-img-style').each(function(){
    $(this).click(function(){
      $('#main_image').attr('src', $(this).attr('src'));
      $('img').removeClass('border-red');
      $(this).addClass('border-red');
    });
  });
})
