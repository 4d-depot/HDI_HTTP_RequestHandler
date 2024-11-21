//%attributes = {}

/**
X Credentials could be generated here: https://developer.x.com/en/portal/dashboard
Google Credentials could be generated here: https://console.cloud.google.com/apis/credentials?project=
Microsoft Credentials could be generated here: https://entra.microsoft.com/#view/Microsoft_AAD_IAM/EntraDashboard.ReactView (More info: https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc#enable-id-tokens)
**/
var $variables:={\
PUBLIC_URL: "http://127.0.0.1"; \
X_CLIENT_ID: "RjF3blRENnA1ZE5VbEtLak84bjc6MTpjaQ"; \
X_CLIENT_SECRET: "wqosSCFwelW4PQK_2Z3TjUGUpublUXjB1NhuXc04BJB2VKU8cA"; \
X_REDIRECT_URI: "/oauth/x/callback"; \
GOOGLE_CLIENT_ID: "1099057521212-ks9rfupkfr9v17hjlrak9abnee0ggs55.apps.googleusercontent.com"; \
GOOGLE_CLIENT_SECRET: "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"; \
GOOGLE_REDIRECT_URI: "/oauth/google/callback"; \
MICROSOFT_CLIENT_ID: "c939e901-0765-4e0c-a1db-1051bccbfec0"; \
MICROSOFT_CLIENT_SECRET: "~Co8Q~q1cDfAagPucC_mNeTsDUUvw2OkagJdEcC8\n"; \
MICROSOFT_REDIRECT_URI: "/oauth/microsoft/callback"\
}

var $notDropped : cs:C1710.SettingsSelection

var $attributes:=OB Keys:C1719($variables)
var $attr : Text
var $vIndex : Integer
var $entity : cs:C1710.SettingsEntity

$notDropped:=ds:C1482.Settings.all().drop()

For ($vIndex; 0; $attributes.length-1)
	$attr:=$attributes[$vIndex]
	$entity:=ds:C1482.Settings.new()
	$entity.key:=$attr
	$entity.value:=$variables[$attr]
	$entity.save()
End for 
