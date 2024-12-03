//%attributes = {}

#DECLARE($name : Text; $what : Text; $width : Integer; $height : Integer) : Text

var $url : Text


$url:="http://127.0.0.1/fileDownload?type="+$what+"&name="+$name

If ($what="image")
	$url:=$url+"&width="+String:C10($width)
	$url:=$url+"&height="+String:C10($height)
End if 


return $url