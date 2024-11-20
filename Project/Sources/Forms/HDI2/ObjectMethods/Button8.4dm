



var $requestObj : Object
var $request : Object




$requestObj:={method: HTTP POST method:K71:2; body: {param: "demo"}}
$request:=4D:C1709.HTTPRequest.new(Form:C1466.startURL; $requestObj).wait()

Form:C1466.response:=$request.response.body

