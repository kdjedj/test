
var x;

window.onload=function(){

}

function b(){
	alert('캬옹');
	x=document.getElementById("x");
	var xx = x.innerHTML;
	//alert(xx);
	console.log(xx);
	window.location.href = "/yy/guest/test2?a="+xx;
}