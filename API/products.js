var http = require('http');
var fs = require('fs');
var url = require('url');

http.createServer(function(request, response) {
    var responseJson = "{}";
    if(request.url.indexOf("products") != -1) {
        fs.readFile('products.json', function (err, data) {
            response.writeHead(200, "Content-Type", "application/json; charset=utf-16");
            response.write(data.toString());
            response.end();
        })
    }
}).listen(8080);
