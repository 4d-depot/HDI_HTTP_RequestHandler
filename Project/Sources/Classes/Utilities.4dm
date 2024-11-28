
shared singleton Class constructor()
	
	
	
exposed Function getError()  // :Object
	If (Session:C1714.storage.error#Null:C1517)
		Web Form:C1735.setError(Session:C1714.storage.error.message)
	End if 