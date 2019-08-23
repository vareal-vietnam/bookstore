$("#new_session").validate({
  errorPlacement: function (error, element) {
    error.addClass('validate-message')
    error.insertAfter(element);
  },
  rules: {
    "session[phone]": {
     required: true,
     valid_phone: ''
    },
    "session[password]": {
      required: true,
      minlength: 6
    }
  },
  highlight: function(element) {
    $(element).addClass('border-red');
  },
  unhighlight: function(element) {
    $(element).removeClass('border-red');
  }
});

$.validator.addMethod("valid_phone", function(value, element) {
  return this.optional(element) || /[0]\d{9}/i.test(value);
}, "Phone include 10 digest and begin by 0");
