

property apiUrl : Text


shared singleton Class constructor()
	
	This:C1470.apiUrl:="https://people.googleapis.com/v1"
	
Function getCurrentUser($token : Text) : Object
	
	var $headers:={Authorization: "Bearer "+$token}
	
	var $body : Object
	
	var $request:=4D:C1709.HTTPRequest.new(This:C1470.apiUrl+"/people/me?personFields=names,emailAddresses"; {method: "GET"; headers: $headers})
	$request.wait()
	
	$body:=$request.response.body
	
	return {\
		username: $body.names[0].displayName; \
		picture: "/$shared/logos/google.webp"}