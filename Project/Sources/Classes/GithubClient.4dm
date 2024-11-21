
shared singleton Class constructor()
	This:C1470.apiUrl:="https://api.github.com"
	
Function getCurrentUser($token : Text) : Object
	
	var $headers:={Authorization: "Bearer "+$token}
	
	$headers["X-GitHub-Api-Version"]:="2022-11-28"
	$headers["Accept"]:="application/vnd.github+json"
	
	var $request:=4D:C1709.HTTPRequest.new(This:C1470.apiUrl+"/user"; {method: "GET"; headers: $headers})
	$request.wait()
	
	var $body:=$request.response.body
	
	return {\
		username: $body.login; \
		fullname: $body.name; \
		picture: $body.avatar_url; \
		email: $body.email\
		}
	