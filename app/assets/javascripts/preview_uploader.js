$(function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      var i;
      for (i = 0; i < input.files.length; i++) {
        if(input.files[i].type.includes("image")) {
          reader.readAsDataURL(input.files[i]);
          break;
        }
      }
    }
  }

  $("#image-upload").change(function(){
    readURL(this);
  });
});
