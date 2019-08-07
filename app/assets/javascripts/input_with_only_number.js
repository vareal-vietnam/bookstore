$(function() {
    $(".number-field").keypress(function(event) {
        if (event.which < 48 || event.which > 57) {
            return false;
        }
    });
});
