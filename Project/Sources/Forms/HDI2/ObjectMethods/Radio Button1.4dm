

If (btnTrace)
	TRACE:C157
End if 


Case of 
	: (Form:C1466.small=1)
		Form:C1466.size:="small"
		
	: (Form:C1466.large=1)
		Form:C1466.size:="large"
End case 

Form:C1466.productURL:=cs:C1710.URLBuilder.me.buildURL(Form:C1466.product; "image"; Form:C1466.size)