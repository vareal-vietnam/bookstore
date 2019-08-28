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
        if(!isImage(input.files[i])) {
          alert("Input files must be image type!" );
          resetUploader("#image-upload");
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

  function isImage(file){
    return file.type.includes("image")
  }

  function resetUploader(uploadId){
    $(uploadId).wrap('<form>').closest('form').get(0).reset();
    $(uploadId).unwrap();
  }
});
