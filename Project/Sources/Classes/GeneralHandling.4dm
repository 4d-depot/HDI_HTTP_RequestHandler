
shared singleton Class constructor()
	
	
Function gettingStarted_Blogpost($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $body : Text
	
	$body:="Called URL: "+$request.url+Char:C90(Carriage return:K15:38)
	
	$body:=$body+"The parameters are received as an object: "+Char:C90(Carriage return:K15:38)+JSON Stringify:C1217($request.urlQuery; *)+Char:C90(Carriage return:K15:38)
	
	$body:=$body+"The verb is: "+$request.verb+Char:C90(Carriage return:K15:38)
	
	$body:=$body+"There are "+String:C10($request.urlPath.length)+" url parts - Url parts are: "+$request.urlPath.join(" - ")+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	
	
	$result.setBody($body)
	$result.setHeader("Content-Type"; "text/plain")
	
	return $result
	
	
	
	
Function gettingStarted($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $body : Text
	
	
	$body:="Called URL: "+$request.url+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	$body:=$body+"The verb is: "+$request.verb+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	$body:=$body+"There are "+String:C10($request.urlPath.length)+" url parts - Url parts are: "+$request.urlPath.join(" - ")+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
	
	Case of 
		: ($request.verb="GET")
			$body:=$body+"The parameters are received as an object: "+Char:C90(Carriage return:K15:38)+JSON Stringify:C1217($request.urlQuery; *)
			
		: ($request.verb="POST")
			
			Case of 
				: (Value type:C1509($request.getJSON())=Is object:K8:27)
					$body:=$body+"The body is received as an object: "+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Value is: "+JSON Stringify:C1217($request.getJSON())
					
				: (Value type:C1509($request.getJSON())=Is text:K8:3)
					$body:=$body+"The body is received as a text: "+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"Value is: "+$request.getText()
			End case 
			
	End case 
	
	$result.setBody($body)
	
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
	
	
Function startProcess($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	Use (Session:C1714.storage)
		Session:C1714.storage.start:=New shared object:C1526("milliseconds"; Milliseconds:C459)
	End use 
	
	DELAY PROCESS:C323(Current process:C322; Num:C11($request.urlQuery.delay))
	
	$cookie:=$request.getHeader("cookie")
	$start:=Position:C15("4DSID_HDI_HTTP_RequestHandler"; $cookie)
	$end:=Position:C15(";"; $cookie)
	
	If ($end>=1)
		$cookie:=Substring:C12($cookie; $start; $end-$start)
	End if 
	
	$headers:=New object:C1471()
	$headers["Cookie"]:=$cookie
	
	$requestObj:={method: HTTP GET method:K71:1; headers: $headers}
	$request:=4D:C1709.HTTPRequest.new("http://127.0.0.1/callBack/"; $requestObj).wait()
	
	$result.setBody($request.response.body)
	
	return $result
	
	
Function handleCallBack() : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	$duration:=Milliseconds:C459-Session:C1714.storage.start.milliseconds
	
	If ($duration>5000)
		$result.setBody("Too late")
	Else 
		$result.setBody("OK")
	End if 
	
	return $result