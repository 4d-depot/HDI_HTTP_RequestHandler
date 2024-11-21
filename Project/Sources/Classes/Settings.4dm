
Class extends DataClass

exposed Function getKey($key : Text) : Text
	
	var $record:=This:C1470.query("key = :1"; $key).first()
	return $record ? $record.value : ""
	