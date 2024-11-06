//%attributes = {}


var $user : cs:C1710.UsersEntity
var $notDropped : cs:C1710.UsersSelection
var $status : Object


//$notDropped:=ds.Users.all().drop()

//$user:=ds.Users.new()
//$user.identifier:="admin@4d.com"
//$user.role:="Admin"
//$user.firstname:="Mary"
//$user.lastname:="Smith"
//$user.password:=Generate password hash("a")
//$status:=$user.save()

//$user:=ds.Users.new()
//$user.identifier:="employee@4d.com"
//$user.firstname:="Helen"
//$user.lastname:="Brown"
//$user.role:="Employee"
//$user.password:=Generate password hash("a")
//$status:=$user.save()

ds:C1482.Products.getProductData()