
shared singleton Class constructor()
	
	
Function handleWebBodyParts() : Object
	
	var $i : Integer
	var $partContent : Blob
	var $partName; $partMimeType; $partFileName : Text
	var $result:={size: 0}
	var $file : 4D:C1709.File
	
	
	For ($i; 1; WEB Get body part count:C1211)
		WEB GET BODY PART:C1212($i; $partContent; $partName; $partMimeType; $partFileName)
		$file:=cs:C1710.FileData.new($partFileName; $partContent)
		$result["file"+String:C10($i)]:=$file
		$result.size:=$result.size+BLOB size:C605($partContent)
	End for 
	
	return $result