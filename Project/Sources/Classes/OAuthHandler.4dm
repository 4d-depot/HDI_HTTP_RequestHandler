
shared singleton Class constructor()
	
	
Function callback($strategy : Text; $req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $registry:=cs:C1710.OAuthRegistry.new()
	
	var $token:=$registry.get($strategy).token($req)
	
	var $extAuth : cs:C1710.oAuth2AuthenticationEntity
	var $status : Object
	var $user : Object
	var $res:=4D:C1709.OutgoingMessage.new()
	
	
	If (Session:C1714.storage.error#Null:C1517)
		$res.setHeader("Location"; "/$lib/renderer/?w=Authentication")
		$res.setStatus(302)
		return $res
	End if 
	
	Case of 
		: ($strategy="twitter")
			$user:=cs:C1710.XClient.me.getCurrentUser($token)
		: ($strategy="google")
			$user:=cs:C1710.GoogleClient.me.getCurrentUser($token)
	End case 
	
	$extAuth:=ds:C1482.oAuth2Authentication.new()
	$extAuth.when:=Current date:C33()
	$extAuth.with:=$strategy
	$extAuth.at:=Current time:C178()
	
	If ($user#Null:C1517)
		$extAuth.userName:=$user.username
		$extAuth.success:=True:C214
		$res.setHeader("Location"; "/$lib/renderer/?w=Authentication")
		$res.setStatus(302)
	Else 
		$res.setBody("<h2 style='text-align: center;color:red'>Error - User not found</h2>")
		$res.setHeader("content-type"; "text/html")
		$res.setStatus(404)
	End if 
	
	$status:=$extAuth.save()
	
	return $res
	
	
Function xAuth($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	var $registry:=cs:C1710.OAuthRegistry.new()
	return $registry.get("twitter").authenticate()
	
Function xAuthCallback($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	return This:C1470.callback("twitter"; $req)
	
Function googleAuth($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	var $registry:=cs:C1710.OAuthRegistry.new()
	return $registry.get("google").authenticate()
	
Function googleAuthCallback($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	return This:C1470.callback("google"; $req)