



var $requestObj : Object
var $request : Object


$requestObj:={method: HTTP DELETE method:K71:5; body: {param: "demo"}}
$request:=4D:C1709.HTTPRequest.new(Form:C1466.startURL; $requestObj).wait()

Form:C1466.response:=$request.response.body

