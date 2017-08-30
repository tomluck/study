class Cat {
    private name: string;
    public setName(s: string) {
        this.name = s.slice(0, 8);
    }
    public getName(): string {
        return this.name;
    }
    public meow(): string {
        return "にゃーん"
    }
}

class Tiger extends Cat {
    public meow(): string {
        return "がおー"
    }
    public meowlikecat(): string {
        return super.meow();
    }
}

var myCat = new Cat();
myCat.setName("じゅげむじゅげむごこうのすりきれねこ");
alert("私の猫の名前は" + myCat.getName() + "です");

var myTiger = new Tiger();
myTiger.setName("とらお");
alert("私の虎の名前は" + myTiger.getName() + "ですが、甘えている時には"
    + myTiger.meowlikecat() + "と鳴きます");

window.close();