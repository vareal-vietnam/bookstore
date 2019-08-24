$(function(){
  $("#new_password_reset").validate({
    errorPlacement: function (error, element) {
      error.addClass('validate-message')
      error.insertAfter(element);
    },
    rules: {
      "password_reset[phone]": {
       required: true,
       valid_phone: ''
      },
      "password_reset[email]": {
        required: true,
        email: true
      },
    },
    highlight: function(element) {
      $(element).addClass('border-red');
    },
    unhighlight: function(element) {
      $(element).removeClass('border-red');
    },
  });

  $.validator.addMethod("valid_phone", function(value, element) {
    return this.optional(element) || /[0]\d{9}/i.test(value);
  }, "Phone include 10 digest and begin by 0");
});
