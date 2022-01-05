var input = {
    "in" : 4541
};

var dictstring = JSON.stringify(input);

var fs = require('fs');
fs.writeFile("./main_js/input.json", dictstring, function(err, result) {
    if(err) console.log('error in creeating input.json', err);
});
/*
var fs = require('fs');
fs.writeFile("./main_cpp/input.json", dictstring, function(err, result) {
    if(err) console.log('error in creeating input.json', err);
});
*/