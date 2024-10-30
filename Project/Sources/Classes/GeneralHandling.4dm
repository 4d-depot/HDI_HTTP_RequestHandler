
shared singleton Class constructor()
	
	
	
Function handleApp($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result : 4D:C1709.OutgoingMessage:=4D:C1709.OutgoingMessage.new()
	
	
	Case of 
		: (Session:C1714.isGuest())
			
			If ($request.url="/myApp/authentication.html")
				$file:=File:C1566("/PACKAGE/WebFolder"+$request.url)
				$result.setBody($file.getContent())
				$result.setHeader("Content-Type"; "text/html")
			Else 
				$result.setHeader("Location"; "http://127.0.0.1:80/error/notAuthenticated.html")
				$result.setStatus(307)
			End if 
			
			
		: (File:C1566("/PACKAGE/WebFolder"+$request.url).exists=False:C215)
			$result.setHeader("Location"; "http://127.0.0.1:80/error/notFound.html")
			$result.setStatus(307)
			
		: (File:C1566("/PACKAGE/WebFolder"+$request.url).exists=True:C214)
			If (($request.urlPath.length=2) && (Position:C15(".html"; $request.url)#0))
				$file:=File:C1566("/PACKAGE/WebFolder"+$request.url)
				$result.setBody($file.getContent())
				$result.setHeader("Content-Type"; "text/html")
			End if 
			
			
			
			
	End case 
	
	return $result
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	$result.setBody("OK handle verb is: "+$r.verb+" and URL is: "+$r.url+" and host is: "+$r.headers.host)
	
	return $result