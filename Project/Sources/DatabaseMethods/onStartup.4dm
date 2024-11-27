
//00_Start

var $webServer; $settings : Object

$settings:=New object:C1471()
$webServer:=WEB Server:C1674
$settings.sessionCookieSameSite:=Web SameSite Lax:K73:36
$webServer.stop()
$webServer.start($settings)

//Use (Storage)
//Storage.session:=New shared object("cookie"; "")
//End use 