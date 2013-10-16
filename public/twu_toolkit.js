$(function () {
  $("input[type=submit]").click(function (element) {
    var button = $(element.target);
    button.addClass('button_loading');
    button.attr('disabled', 'disabled'); 
    debugger;
    button.parent().parent().submit();
  });
});
