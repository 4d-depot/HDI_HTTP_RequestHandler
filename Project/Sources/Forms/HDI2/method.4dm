Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		InitInfo
		
		// Page 1
		Form:C1466.products:=ds:C1482.Products.all()
		
		Form:C1466.small:=1
		
		Form:C1466.size:="small"
		
		LISTBOX SELECT ROW:C912(*; "Products"; 1; lk replace selection:K53:1)
		
		Form:C1466.product:=Form:C1466.products.first()
		
		Form:C1466.url:=cs:C1710.URLBuilder.me.buildURL(Form:C1466.product; "image"; Form:C1466.size)
		
		
		
	: (Form event code:C388=On Page Change:K2:54)
		
		
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 

