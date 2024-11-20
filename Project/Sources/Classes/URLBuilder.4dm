
shared singleton Class constructor()
	
	
exposed Function buildURL($product : cs:C1710.ProductsEntity; $what : Text; $size : Text) : Text
	
	var $url : Text
	var $width; $height : Integer
	
	Case of 
			
		: ($what="userManual")
			$url:=getURL($product.name; $what)
			
		: ($size="small")
			$width:=200
			$height:=200
			$url:=getURL($product.name; $what; $width; $height)
			
		: ($size="large")
			$width:=400
			$height:=400
			$url:=getURL($product.name; $what; $width; $height)
			
	End case 
	
	return $url
	
	