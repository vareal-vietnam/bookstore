$(function() {
  var defaultURL = $('#img_prev').attr('src');
  function showImagePreview(input) {
    if (input.files) {
      var reader = new FileReader();
      var i, filesCount = input.files.length;
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      for (i = 0; i < filesCount; i++) {
        if(!(input.files[i].type.includes("image"))) {
          alert("Input files must be image type!" );
          $('#image-upload').wrap('<form>').closest('form').get(0).reset();
          $('#image-upload').unwrap();
          break;
        }
      }
      if (i == filesCount) {
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
