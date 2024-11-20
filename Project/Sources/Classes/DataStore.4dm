Class extends DataStoreImplementation



exposed Function authentify($credentials : Object) : Text
	
	var $users : cs:C1710.UsersSelection
	var $user : cs:C1710.UsersEntity
	var $result : Text
	
	$result:="Authentication failed"
	
	$users:=ds:C1482.Users.query("identifier = :1"; $credentials.identifier)
	$user:=$users.first()
	
	If ($user#Null:C1517)
		If (Verify password hash:C1534($credentials.password; $user.password))
			Session:C1714.clearPrivileges()
			Session:C1714.setPrivileges({roles: $user.role})
			
			Use (Session:C1714.storage)
				Session:C1714.storage.info:=New shared object:C1526("fullname"; $user.fullname; "role"; $user.role)
			End use 
			
			
			$result:="OK"
		End if 
		
	End if 
	
	return $result
	
exposed Function clearSession() : Text
	Session:C1714.clearPrivileges()
	return "OK"
	
exposed Function getPrivileges() : Text
	return Session:C1714.getPrivileges().join(",")
	
	