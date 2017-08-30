var price:number = 1200;
var rate:number = 0.08;
var message:string = "円（税込み）"
var isInc:boolean = false;
if (isInc) {
    alert(price + message);
} else {
    alert(price * (1 + rate) + message);
}