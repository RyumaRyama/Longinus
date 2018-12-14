$(document).on('turbolinks:load',
function create_link(){
  var link=document.URL;
  $('#code').empty();
  $('#code').qrcode({
    width: 100,
    height: 100,
    text: link
  });
  $('canvas').attr('id', 'code');
});