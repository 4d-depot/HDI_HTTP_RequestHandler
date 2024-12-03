shared singleton Class constructor()
	
	
Function gettingStarted_forBlogpost($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $body : Text
	
	$body:="Called URL: "+$request.url+"\n"
	
	$body+="The parameters are received as an object:"+"\n"+JSON Stringify:C1217($request.urlQuery; *)+"\n"
	
	$body+="The verb is: "+$request.verb+"\n"
	
	$body+="There are "+String:C10($request.urlPath.length)+" url parts - Url parts are: "+$request.urlPath.join(" - ")+"\n"+"\n"
	
	$result.setBody($body)
	$result.setHeader("Content-Type"; "text/plain")
	
	return $result
	
	
	
	
Function gettingStarted($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $body : Text
	var $bodyText; $header : Text
	var $bodyObj : Object
	
	
	$body:="Called URL: "+$request.url+"\n"+"\n"
	$body+="The verb is: "+$request.verb+"\n"+"\n"
	$body+="There are "+String:C10($request.urlPath.length)+" url parts - Url parts are: "+$request.urlPath.join(" - ")+"\n"+"\n"
	
	Case of 
		: ($request.verb="GET")
			$body+="The parameters are received as an object:"+"\n"+JSON Stringify:C1217($request.urlQuery; *)
			
		: ($request.verb="POST")
			
			$header:=$request.getHeader("content-type")
			
			Case of 
				: ($header="application/json")
					
					$bodyObj:=$request.getJSON()
					
					If (Value type:C1509($bodyObj)=Is object:K8:27)
						$body+="The body is received as an object:"+"\n"+"\n"+"Value is: "+JSON Stringify:C1217($bodyObj)
					End if 
					
				: ($header="text/plain")
					
					$bodyText:=$request.getText()
					
					If (Value type:C1509($bodyText)=Is text:K8:3)
						$body+="The body is received as a text:"+"\n"+"\n"+"Value is: "+$bodyText
					End if 
					
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
			$result.setHeader("Location"; "/authentication/authentication.html")
			$result.setStatus(307)
			
		: (($urlPath.length=2) && (Position:C15("/myApp/"; $url)#0) && (Position:C15(".html"; $url)#0))
			$file:=File:C1566("/PACKAGE/WebFolder"+$url)
			If ($file.exists)
				$result.setBody($file.getContent())
				$result.setHeader("Content-Type"; "text/html")
			Else 
				$result.setHeader("Location"; "/error/notFound.html")
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
			$result.setHeader("Location"; "/error/notAuthorized.html")
			$result.setStatus(307)
	End case 
	
	return $result
	
	
Function startProcess($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $headers:=New object:C1471()
	var $requestObj; $callback : Object
	
	
	Use (Session:C1714.storage)
		Session:C1714.storage.start:=New shared object:C1526("begin"; Milliseconds:C459)
	End use 
	
	DELAY PROCESS:C323(Current process:C322; (Num:C11($request.urlQuery.delay)*60))
	
	$headers["Cookie"]:=$request.getHeader("cookie")
	$requestObj:={method: HTTP GET method:K71:1; headers: $headers}
	$callback:=4D:C1709.HTTPRequest.new("http://127.0.0.1/callBack/"; $requestObj).wait()
	
	$result.setBody($callback.response.body)
	$result.setHeader("Content-Type"; $callback.response.headers["content-type"])
	
	return $result
	
	
Function handleCallBack() : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	
	var $duration : Integer
	
	$duration:=Milliseconds:C459-Session:C1714.storage.start.begin
	
	If ($duration>3000)
		$result.setBody("Too late")
	Else 
		$result.setBody("OK")
	End if 
	
	return $result