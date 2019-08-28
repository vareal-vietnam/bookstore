$(function(){
  $("#avatar-upload").change(function(){
     var file = this.files[0];
     var fileType = file["type"];
     var validImageTypes = ["image/gif", "image/jpeg", "image/png", "img/jpg"];
     if ($.inArray(fileType, validImageTypes) < 0) {
      alert("Input files must be image type!" );
      $("#avatar-upload").wrap('<form>').closest('form').get(0).reset();
      $("#avatar-upload").unwrap();
    }
  });
});
