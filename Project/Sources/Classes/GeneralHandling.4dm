
shared singleton Class constructor()
	
	
	
Function gettingStarted($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $body : Text
	
	
	Case of 
		: ($request.verb="GET")
			$result.setBody("Calling URL "+$request.url+" has been handled with the GET verb - Param in the URL is "+$request.urlQuery.param)
			$result.setHeader("Content-Type"; "text/plain")
			
		: ($request.verb="POST")
			
			$body:="Calling URL "+$request.url+" has been handled with the POST verb - Param in the body is "
			
			If (Value type:C1509($request.getJSON())=Is object:K8:27)
				$body:=$body+"object and value is "+JSON Stringify:C1217($request.getJSON())
			End if 
			
			$result.setBody($body)
			$result.setHeader("Content-Type"; "text/plain")
			
	End case 
	
	return $result
	
	
Function handleApp($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	If (Session:C1714.isGuest())
		Use (Session:C1714.storage)
			Session:C1714.storage.redirection:=New shared object:C1526("url"; $request.url; "urlPath"; $request.urlPath.copy(ck shared:K85:29; Session:C1714.storage.redirection))
		End use 
	End if 
	
	return This:C1470.redirect($request.url; $request.urlPath)
	
	
	
Function redirect($url : Text; $urlPath : Collection) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $file : 4D:C1709.File
	
	
	Case of 
		: (Session:C1714.isGuest())
			$result.setHeader("Location"; "http://127.0.0.1/authentication/authentication.html")
			$result.setStatus(307)
			
		: (($urlPath.length=2) && (Position:C15("/myApp/"; $url)#0) && (Position:C15(".html"; $url)#0))
			$file:=File:C1566("/PACKAGE/WebFolder"+$url)
			If ($file.exists)
				$result.setBody($file.getContent())
				$result.setHeader("Content-Type"; "text/html")
			Else 
				$result.setHeader("Location"; "http://127.0.0.1/error/notFound.html")
				$result.setStatus(307)
			End if 
			
		: (Session:C1714.storage.redirection.url#"")
			$url:=Session:C1714.storage.redirection.url
			$urlPath:=Session:C1714.storage.redirection.urlPath
			Use (Session:C1714.storage)
				Session:C1714.storage.redirection:=New shared object:C1526("url"; "")
			End use 
			$result:=This:C1470.redirect($url; $urlPath)
			
		: (($urlPath.length=1) && ($url="/myApp"))
			$file:=File:C1566("/PACKAGE/WebFolder/myApp/welcome.html")
			$result.setBody($file.getContent())
			$result.setHeader("Content-Type"; "text/html")
			
			
		Else 
			$result.setHeader("Location"; "http://127.0.0.1/error/notAuthorized.html")
			$result.setStatus(307)
	End case 
	
	return $result