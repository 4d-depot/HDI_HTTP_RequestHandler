//%attributes = {}

#DECLARE($name : Text; $what : Text; $width : Integer; $height : Integer) : Text

var $url : Text




//http://127.0.0.1/fileDownload?name=xxx&width=xxx@height=yyy

$url:="http://127.0.0.1/fileDownload?type="+$what+"&name="+$name

If ($what="image")
	$url:=$url+"&width="+String:C10($width)
	$url:=$url+"&height="+String:C10($height)
End if 

//$url:="http://127.0.0.1:80/rest/Products/getThumbnail?$params="

//$url:=$url+"'["

//$url:=$url+"\""

//$url:=$url+$name+"\""

//$url:=$url+","+String($width)+","+String($height)

//$url:=$url+"]'"

return $url