



var $requestObj : Object
var $request : Object

If (btnTrace)
	TRACE:C157
End if 


$requestObj:={method: HTTP DELETE method:K71:5; body: {param: "demo"; name: "4D"}}
$request:=4D:C1709.HTTPRequest.new(Form:C1466.startURL; $requestObj).wait()

Form:C1466.response:=$request.response.body

