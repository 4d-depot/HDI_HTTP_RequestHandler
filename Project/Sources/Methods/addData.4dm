//%attributes = {}


var $user : cs:C1710.UsersEntity
var $notDropped : cs:C1710.UsersSelection
var $status : Object


$notDropped:=ds:C1482.Users.all().drop()

$user:=ds:C1482.Users.new()
$user.identifier:="admin@4d.com"
$user.role:="Admin"
$user.password:=Generate password hash:C1533("a")
$status:=$user.save()

$user:=ds:C1482.Users.new()
$user.identifier:="employee@4d.com"
$user.role:="Employee"
$user.password:=Generate password hash:C1533("a")
$status:=$user.save()