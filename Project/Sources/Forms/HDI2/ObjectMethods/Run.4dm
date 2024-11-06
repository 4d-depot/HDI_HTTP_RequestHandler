

getShoppingListURL

OBJECT SET ENABLED:C1123(*; "Download"; True:C214)


LISTBOX SELECT ROWS:C1715(*; "ProductsLB"; ds:C1482.Products.query("price <= :1"; 100); lk replace selection:K53:1)