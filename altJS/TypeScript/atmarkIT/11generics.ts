function parrot<T>(data: T): T {
    var ret: T;
    ret = data;
    return ret;
}
alert(parrot<number>(100));
windows.close();
