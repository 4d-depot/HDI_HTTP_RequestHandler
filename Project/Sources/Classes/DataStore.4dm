Class extends DataStoreImplementation



//exposed Function authentify($credentials : Object) : Text

//var $users : cs.UsersSelection
//var $user : cs.UsersEntity
//var $result : Text

//$result:="Authentication failed"

//$users:=ds.Users.query("identifier = :1"; $credentials.identifier)
//$user:=$users.first()

//If ($user#Null)
//If (Verify password hash($credentials.password; $user.password))
//Session.clearPrivileges()
//Session.setPrivileges({roles: $user.role})

//Use (Session.storage)
//Session.storage.info:=New shared object("fullname"; $user.fullname; "role"; $user.role)
//End use 

//$result:="OK"
//End if 

//End if 

//return $result

exposed Function clearSession() : Text
	Session:C1714.clearPrivileges()
	return "OK"
	