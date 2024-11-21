
shared singleton Class constructor()
	
	
	This:C1470.apiUrl:="https://graph.microsoft.com/oidc"
	
Function getCurrentUser($token : Text) : Object
	
	var $headers:={Authorization: "Bearer "+$token}
	
	var $request:=4D:C1709.HTTPRequest.new(This:C1470.apiUrl+"/userinfo"; {method: "GET"; headers: $headers})
	$request.wait()
	
	var $body:=$request.response.body
	
	return {\
		username: $body.email; \
		fullname: $body.name; \
		picture: "/$shared/logos/microsoft.webp"; \
		email: $body.email\
		}
	