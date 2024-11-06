

If (Form:C1466.userManual=1)
	Form:C1466.url:=cs:C1710.URLBuilder.me.buildURL(Form:C1466.product; "userManual")
Else 
	Form:C1466.url:=cs:C1710.URLBuilder.me.buildURL(Form:C1466.product; "image"; Form:C1466.size)
End if 