var counter = 1;
var target = "elements[][name]";
var value = [];
var input = " ";
var data=[];
var form_max=10; 
function CheckInputValue(counter) {
    for (let i = 0; i < counter; i++) {
        value[i] = area[i].value;
        console.log(value[i],i);
    }
    return value;
}

function Createbutton(counter,value) {
  
    for (let i = 0; i < counter; i++) {
        //入力フォームのコードを変数に追加
        
        input = input + "<input type=\"text\" name=\"elements[][name]\" id=\"elements__name\"";
        if (data[i]) {
          console.log(data[i]);
          input = input + " value=\"" + data[i] + "\"";
        }
        input = input + ">";
    }
    input=input+"<br><button class=\"btn btn-outline\" onclick=\"add_button()\">趣味をさらに追加</button>";
}
function ChangeFrom(input){
  //入力フォームを格納するエリアに追加
    input_area.innerHTML="";
    input_area.innerHTML= input;
}

function add_button() {
    area = document.getElementsByName(target);
    area = Array.from(area);
    data=[];
    data=CheckInputValue(counter);
    //10個以上は使えないように制限
    if (counter < form_max) {
        //counter変数を1追加
        counter++;
    }
    input="";
    Createbutton(counter,data);
    ChangeFrom(input);
}