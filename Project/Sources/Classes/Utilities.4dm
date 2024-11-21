
shared singleton Class constructor()
	
	
exposed Function getUser() : Object
	return Session:C1714.storage.info
	
	
exposed Function getError()  // :Object
	//Web Form.setError("KO")
	
	If (Session:C1714.storage.error#Null:C1517)
		Web Form:C1735.setError(Session:C1714.storage.error.message)
	End if 