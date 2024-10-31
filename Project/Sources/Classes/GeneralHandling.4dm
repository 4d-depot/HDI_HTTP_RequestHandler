
shared singleton Class constructor()
	
	
	
Function handleApp($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $result:=4D:C1709.OutgoingMessage.new()
	var $file : 4D:C1709.File
	
	
	If (Session:C1714.isGuest())
		
		
		
		
		$result.setHeader("Location"; "http://127.0.0.1/authentication/authentication.html")
		$result.setStatus(307)
		
	Else 
		If (($request.urlPath.length=2) && (Position:C15("/myApp/"; $request.url)#0) && (Position:C15(".html"; $request.url)#0))
			$file:=File:C1566("/PACKAGE/WebFolder"+$request.url)
			If ($file.exists)
				$result.setBody($file.getContent())
				$result.setHeader("Content-Type"; "text/html")
			Else 
				$result.setHeader("Location"; "http://127.0.0.1/error/notFound.html")
				$result.setStatus(307)
			End if 
		Else 
			$result.setHeader("Location"; "http://127.0.0.1/error/notAuthorized.html")
			$result.setStatus(307)
		End if 
		
	End if 
	
	return $result