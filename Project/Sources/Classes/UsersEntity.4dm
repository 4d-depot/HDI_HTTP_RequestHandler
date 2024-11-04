Class extends Entity


exposed Function get fullname() : Text
	
	Case of 
			
		: (This:C1470.firstname=Null:C1517)
			If (This:C1470.lastname=Null:C1517)
				return ""
			Else 
				return This:C1470.lastname
			End if 
			
		: (This:C1470.lastname=Null:C1517)
			If (This:C1470.firstname=Null:C1517)
				return ""
			Else 
				return This:C1470.firstname
			End if 
			
		Else 
			return This:C1470.firstname+" "+This:C1470.lastname
			
	End case 