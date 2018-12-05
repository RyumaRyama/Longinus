$(document).on('turbolinks:load',
function create_link(){
  var link=document.URL;
  document.getElementById('txt_share').value=link;
  var clipboard = new Clipboard('#cp');
  clipboard.on('success', function(e) {
    e.clearSelection();
    });
    $('#code').empty();
    $('#code').qrcode({
      width: 100,
      height: 100,
      text: link
    });
    $('canvas').attr('id', 'code');
});