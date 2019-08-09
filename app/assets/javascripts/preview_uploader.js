$(function() {
  var defaultURL = $('#img_prev').attr('src');
  function showImagePreview(input) {
    if (input.files) {
      var reader = new FileReader();
      var validFiles = true;
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      for (var i = 0; i < input.files.length; i++) {
        if(!(input.files[i].type.includes("image"))) {
          alert("Input files must be image type!" );
          $('#image-upload').wrap('<form>').closest('form').get(0).reset();
          $('#image-upload').unwrap();
          validFiles = false;
          break;
        }
      }
      if (validFiles) {
        reader.readAsDataURL(input.files[0]);
      }
    }
  }

  $("#image-upload").change(function(){
    showImagePreview(this);
  });

  $("#image-upload").click(function(){
    $('#img_prev').attr('src', defaultURL);
  });
});
