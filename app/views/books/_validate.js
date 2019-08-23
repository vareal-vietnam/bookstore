
$("#new_book").validate({
  errorPlacement: function (error, element) {
    error.addClass('validate-message')
    error.insertAfter(element);
  },
  rules: {
    "book[name]": {
     required: true
    },
    "book[quantity]": {
      required: true,
      min: 0
    },
    "book[price]": {
      required: true,
      min: 0
    },
    "book[description]": {
      required: true
    }
  },
  highlight: function(element) {
    $(element).addClass('border-red');
  },
  unhighlight: function(element) {
    $(element).removeClass('border-red');
  }
});
