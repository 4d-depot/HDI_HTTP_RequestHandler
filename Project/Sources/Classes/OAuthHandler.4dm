
shared singleton Class constructor()
	
	
Function callback($strategy : Text; $req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $registry:=cs:C1710.OAuthRegistry.new()
	
	var $token:=$registry.get($strategy).token($req)
	
	//var $oauth : Collection
	var $extAuth : cs:C1710.ExternalAuthenticationEntity
	var $status : Object
	var $user : Object
	var $res:=4D:C1709.OutgoingMessage.new()
	
	
	//If (Value type($token)=Is object && OB Instance of($token; 4D.OutgoingMessage))
	//return $token
	//End if 
	
	If (Session:C1714.storage.error#Null:C1517)
		$res.setHeader("Location"; "/$lib/renderer/?w=Authentication")
		$res.setStatus(302)
		return $res
	End if 
	
	//If (Session.storage.oauth=Null)
	//Use (Session.storage)
	//Session.storage.oauth:=New shared collection()
	//End use 
	//End if 
	
	//$oauth:=Session.storage.oauth
	
	Case of 
		: ($strategy="twitter")
			$user:=cs:C1710.XClient.me.getCurrentUser($token)
		: ($strategy="google")
			$user:=cs:C1710.GoogleClient.me.getCurrentUser($token)
		: ($strategy="microsoft")
			$user:=cs:C1710.MicrosoftClient.me.getCurrentUser($token)
		: ($strategy="github")
			$user:=cs:C1710.GithubClient.me.getCurrentUser($token)
	End case 
	
	//var $found
	//var $sharedUser:=New shared object()
	
	$extAuth:=ds:C1482.ExternalAuthentication.new()
	$extAuth.when:=Current date:C33()
	$extAuth.with:=$strategy
	$extAuth.at:=Current time:C178()
	
	If ($user#Null:C1517)
		//Use ($sharedUser)
		//$sharedUser.strategy:=$strategy
		//$sharedUser.username:=$user.username
		//$sharedUser.fullname:=$user.fullname
		//$sharedUser.picture:=$user.picture
		//$sharedUser.email:=$user.email
		//End use 
		
		//$found:=$oauth.findIndex(Formula($1.value.strategy=$strategy))
		
		//Use ($oauth)
		//If ($found>=0)
		//$oauth[$found]:=$sharedUser
		//Else 
		//$oauth.push($sharedUser)
		//End if 
		//End use 
		
		$extAuth.userName:=$user.username
		$extAuth.success:=True:C214
		$res.setHeader("Location"; "/$lib/renderer/?w=Authentication")
		$res.setStatus(302)
	Else 
		//$extAuth.userName:="Failed authentication"
		//$extAuth.success:=False
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
	
Function microsoftAuth($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	var $registry:=cs:C1710.OAuthRegistry.new()
	return $registry.get("microsoft").authenticate()
	
Function microsoftAuthCallback($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	return This:C1470.callback("microsoft"; $req)
	
Function githubAuth($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	var $registry:=cs:C1710.OAuthRegistry.new()
	return $registry.get("github").authenticate()
	
Function githubAuthCallback($req : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	return This:C1470.callback("github"; $req)
	