$("#new_book_request").validate({
  errorPlacement: function (error, element) {
    error.addClass('validate-message')
    error.insertAfter(element);
  },
  rules: {
    "book_request[name]": {
     required: true
    },
    "book_request[quantity]": {
      required: true,
      min: 0,
      max: 100000
    },
    "book_request[budget]": {
      required: true,
      min: 0,
      max: 100
    }
  },
  highlight: function(element) {
    $(element).addClass('border-red');
  },
  unhighlight: function(element) {
    $(element).removeClass('border-red');
  }
});
