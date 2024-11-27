
shared singleton Class constructor()
	
	
Function authenticate($request : 4D:C1709.IncomingMessage) : 4D:C1709.OutgoingMessage
	
	var $users : cs:C1710.UsersSelection
	var $user : cs:C1710.UsersEntity
	var $result:=4D:C1709.OutgoingMessage.new()
	
	var $credentials:=$request.getJSON()
	
	$result.setBody("Authentication failed")
	
	$users:=ds:C1482.Users.query("identifier = :1"; $credentials.identifier)
	$user:=$users.first()
	
	If ($user#Null:C1517)
		If (Verify password hash:C1534($credentials.password; $user.password))
			Session:C1714.clearPrivileges()
			Session:C1714.setPrivileges({roles: $user.role})
			
			Use (Session:C1714.storage)
				Session:C1714.storage.info:=New shared object:C1526("fullname"; $user.fullname; "role"; $user.role)
			End use 
			
			$result.setBody("OK")
		End if 
		
	End if 
	
	return $result