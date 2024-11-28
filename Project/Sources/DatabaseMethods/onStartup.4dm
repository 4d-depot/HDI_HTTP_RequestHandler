
00_Start

var $notDropped : cs:C1710.oAuth2AuthenticationSelection

var $webServer; $settings : Object

$settings:=New object:C1471()
$webServer:=WEB Server:C1674
$settings.sessionCookieSameSite:=Web SameSite Lax:K73:36
$webServer.stop()
$webServer.start($settings)

generate_settings

$notDropped:=ds:C1482.oAuth2Authentication.all().drop()