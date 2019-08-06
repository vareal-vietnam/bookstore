setTimeoutHideFlashMessage();

$('.flash-message').change(function() {
  setTimeoutHideFlashMessage();
})

function setTimeoutHideFlashMessage() {
  setTimeout("$('.flash-message').fadeOut('fast')", 5000);
}
