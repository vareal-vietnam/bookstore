$(function() {
  function showImagePreview(input) {
    if (input.files) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }

      for (var i = 0; i < input.files.length; i++) {
        if(input.files[i].type.includes("image")) {
          reader.readAsDataURL(input.files[i]);
          break;
        }
      }
    }
  }

  $("#image-upload").change(function(){
    showImagePreview(this);
  });
});
