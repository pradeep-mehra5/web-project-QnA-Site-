function search(){
    var input, filter,div,b1,b2,i,a;
    input= document.getElementById("srch-term");
    filter= input.value.toUpperCase();
    div= document.getElementsByClassName("list-group")[0];
    a1=div.getElementsByClassName("list-group-item-action");
    for(i=0;i<a1.length ;i++){
        b1=a1[i].getElementsByTagName("a")[0];
        b2=a1[i].getElementsByTagName("em")[0];
        if(b1.innerHTML.toUpperCase().indexOf(filter)>-1 || b2.innerHTML.toUpperCase().indexOf(filter)==0){
            a1[i].style.display="";
        }
        else{
            a1[i].style.display="none";
        }
    }
}


