$("#new_user").validate({
  errorPlacement: function (error, element) {
    error.addClass('validate-message')
    error.insertAfter(element);
  },
  rules: {
    "user[name]": {
     required: true
    },
    "user[phone]": {
      required: true,
      valid_phone: ''
    },
    "user[address]": {
      required: true
    },
    "user[password]": {
      required: true,
      minlength: 6
    },
    "user[password_confirmation]": {
      required: true,
      password_confirmation: ''
    }
  },
  highlight: function(element) {
    $(element).addClass('');
    $(element).addClass('border-red');
  },
  unhighlight: function(element) {
    $(element).removeClass('border-red');
  }
});

$.validator.addMethod("valid_phone", function(value, element) {
  return this.optional(element) || /[0]\d{9}/i.test(value);
}, "Phone include 10 digest and begin by 0");

$.validator.addMethod("password_confirmation", function(value, element) {
  return this.optional(element) || $('#user_password').val() == value;
}, "Password not match");
