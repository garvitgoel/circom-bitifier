pragma circom 2.0.0;
/*
template DeBitify(n){
    signal input bits[n];
    signal output num;
    var temp_num = 0;
    for (var i=0; i<n; i++){
        temp_num = temp_num + bits[i] * 2**i;
    }

    num <== temp_num;
}*/

template Bitify(n){
    signal input num;
    signal output bits[n];
    var temp = num;
    var q;
    var r;
    var i;

    for (i=0; i<n; i++){
        q = temp \ 2;
        r = temp - 2*q;
        bits[i] <== r;
        temp = q;
    }
}

template Main(n) {
    signal input in;
    signal output out[n];
    component bitify = Bitify(n);
    var i;

    bitify.num <== in;
    for (i=0; i<n; i++){
        bitify.bits[i] ==> out[i];
    }

}
component main = Main(32);