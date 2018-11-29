$(document).on('turbolinks:load',
function create_link(){
  var link=document.URL;
  var messege="私はこんな趣味を持ってるよ！ "+link+" あなたもホビコムで大事な趣味を共有しよう!!";
  document.getElementById('txt_share').value=messege;
  var clipboard = new Clipboard('#cp');
  clipboard.on('success', function(e) {
    e.clearSelection();
    });
});