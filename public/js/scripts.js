$(document).ready(function() {

  $('html').click(function() {
    var r = Math.floor(Math.random() * (255 - 0));
    var g = Math.floor(Math.random() * (255 - 0));
    var b = Math.floor(Math.random() * (255 - 0));
    $('body').css('background-color', 'rgb(' + r + ',' + g + ',' + b + ')');
  });

});
