$(function () {
  $("input[type=submit]").click(function (element) {
    var button = $(element.target);
    button.addClass('button_loading');
    button.attr('disabled', 'disabled'); 
    button.parent().submit();
  });
});
