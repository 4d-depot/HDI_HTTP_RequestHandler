

property name : Text
property options : Object
property authOpts : Object
property tokenOpts : Object


Class constructor($name : Text; $options : Object; $authOpts : Object; $tokenOpts : Object)
	
	This:C1470.name:=$name
	This:C1470.options:=$options
	This:C1470.authOpts:=$authOpts
	This:C1470.tokenOpts:=$tokenOpts
	
Function renderError($error : Text; $statusCode : Integer) : 4D:C1709.OutgoingMessage
	
	var $res:=4D:C1709.OutgoingMessage.new()
	$res.setBody("<h2 style='text-align: center;color:red'>Error - "+$error+"</h2>")
	$res.setHeader("content-type"; "text/html")
	$res.setStatus($statusCode)
	return $res
	
Function encodeURI($text : Text) : Text
	
	$text:=Replace string:C233($text; ","; "%3B")  // , semicolon"
	$text:=Replace string:C233($text; "/"; "%2F")  // / backslash
	$text:=Replace string:C233($text; "?"; "%3F")  // ? question mark
	$text:=Replace string:C233($text; ":"; "%3A")  // : colon
	$text:=Replace string:C233($text; "@"; "%40")  // @ at
	$text:=Replace string:C233($text; "&"; "%26")  // & ampersand
	$text:=Replace string:C233($text; "="; "%3D")  // = equal
	$text:=Replace string:C233($text; "+"; "%2B")  // + plus sign
	$text:=Replace string:C233($text; ","; "%2C")  // , comma
	$text:=Replace string:C233($text; "$"; "%24")
	return $text
	
Function objectToUrlEncoded($obj : Object) : Text
	
	var $url:=""
	var $attributes:=OB Keys:C1719($obj)
	var $attr : Text
	var $vIndex : Integer
	
	For ($vIndex; 0; $attributes.length-1)
		$attr:=$attributes[$vIndex]
		If ($vIndex>0)
			$url+="&"
		End if 
		$url+=$attr+"="+$obj[$attr]
	End for 
	
	return $url
	
Function authenticate() : 4D:C1709.OutgoingMessage
	
	var $res:=4D:C1709.OutgoingMessage.new()
	var $url:=""
	
	$url+=This:C1470.options.authorizeUrl
	$url+="?response_type=code"
	$url+="&client_id="+This:C1470.options.clientId
	$url+="&redirect_uri="+This:C1470.options.redirectUri
	$url+="&scope="+This:C1470.options.scope
	$url+="&state="+Session:C1714.id
	$url+="&"+This:C1470.objectToUrlEncoded(This:C1470.authOpts)
	
	$res.setStatus(302)
	$res.setHeader("Location"; $url)
	return $res
	
	
Function token($req : 4D:C1709.IncomingMessage) : Text
	
	Use (Session:C1714.storage)
		Session:C1714.storage.error:=Null:C1517
	End use 
	
	If ($req.urlQuery.error#Null:C1517)
		Use (Session:C1714.storage)
			Session:C1714.storage.error:=New shared object:C1526("message"; $req.urlQuery.error)
		End use 
		return ""
	Else 
		
		var $redirectUri:=This:C1470.encodeURI(This:C1470.options.redirectUri)
		
		var $credentials:=""
		BASE64 ENCODE:C895(This:C1470.options.clientId+":"+This:C1470.options.clientSecret; $credentials)
		
		var $headers:={Authorization: "Basic "+$credentials}
		$headers["Content-Type"]:="application/x-www-form-urlencoded"
		//headers["Accept"] = "application/json"
		
		var $body:=""
		$body+="code="+$req.urlQuery.code
		$body+="&grant_type=authorization_code"
		$body+="&client_id="+This:C1470.options.clientId
		$body+="&redirect_uri="+$redirectUri
		$body+="&"+This:C1470.objectToUrlEncoded(This:C1470.tokenOpts)
		
		var $request:=4D:C1709.HTTPRequest.new(This:C1470.options.tokenUrl; {method: "POST"; headers: $headers; body: $body})
		$request.wait()
		
		If ($request.response.status#200)
			
			Use (Session:C1714.storage)
				Session:C1714.storage.error:=New shared object:C1526("message"; $request.response.body.error_description; "status"; $request.response.status)
			End use 
			return ""
			//return This.renderError($request.response.body.error_description; $request.response.status)
		End if 
		
	End if 
	
	return $request.response.body.access_token