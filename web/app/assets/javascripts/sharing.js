$(document).on('turbolinks:load',
function create_link(){
  var link=document.URL;
  $('#code').empty();
  //create code configration
  var codeConf='{"size":"200x200","EnCode":"UTF-8","link":"'+link+'"}';
  var data=JSON.parse(codeConf);
  //create image tag
  var img = $('<img>').attr('src', 'https://chart.apis.google.com/chart?cht=qr&chs='+data.size+'&choe='+data.EnCode+'&chl=' + data.link);
  //add crated image tag(add to barcode area)
  $('#code').html(img);
});