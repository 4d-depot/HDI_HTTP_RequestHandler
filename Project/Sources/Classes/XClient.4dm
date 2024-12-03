
property apiUrl : Text

shared singleton Class constructor()
	
	This:C1470.apiUrl:="https://api.x.com/2"
	
Function getCurrentUser($token : Text) : Object
	
	var $headers:={Authorization: "Bearer "+$token}
	var $body : Object
	
	var $request:=4D:C1709.HTTPRequest.new(This:C1470.apiUrl+"/users/me?user.fields=profile_image_url"; {method: "GET"; headers: $headers})
	$request.wait()
	
	$body:=$request.response.body.data
	
	return {\
		username: $body.username; \
		fullname: $body.name; \
		picture: Replace string:C233($body.profile_image_url; "_normal"; "_400x400"); \
		email: Null:C1517\
		}
	