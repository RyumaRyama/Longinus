var counter = 1;
var target = "elements[][name]";
var value = [];
var input = " ";
var data=[];
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
    input=input+"<br><button class=\"btn btn-outline-primary\" onclick=\"add_button()\">趣味をさらに追加</button>";
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
    if (counter < 10) {
        //counter変数を1追加
        counter++;
    }
    input="";
    Createbutton(counter,data);
    ChangeFrom(input);
}
function RemoveInput(counter,data,num){
  for (let i = 0; i < counter; i++) {
        while(i!=num && i+1<counter){
          data[i]=data[i+1];
        }
    }
    return value;
}
function remove_button(num) {
 
    //counterが1より小さくならないようにする(フォームは最低でも1つ残す)
    if (counter > 1) {
        counter--;
        value=[];
    }
    console.log(num);
     area = document.getElementsByName(target);
    area = Array.from(area);
    data=[];
    data=CheckInputValue(counter);
    RemoveInput(counter,data,num);
    input="";
    Createbutton(counter);
    ChangeFrom(input);
}
