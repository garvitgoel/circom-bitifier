pragma circom 2.0.0;

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
        out[i] <== bitify.bits[i];
    }

}
component main = Main(32);