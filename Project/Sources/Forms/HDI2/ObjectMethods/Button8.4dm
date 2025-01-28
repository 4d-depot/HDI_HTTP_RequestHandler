

var $requestObj : Object
var $request : Object

If (btnTrace)
	TRACE:C157
End if 


Case of 
	: (Form:C1466.json=1)
		$requestObj:={method: HTTP POST method:K71:2; body: {param: "demo"; name: "4D"}}
		
	: (Form:C1466.text=1)
		$requestObj:={method: HTTP POST method:K71:2; body: "Some text"}
End case 


$request:=4D:C1709.HTTPRequest.new(Form:C1466.startURL; $requestObj).wait()

Form:C1466.response:=$request.response.body

