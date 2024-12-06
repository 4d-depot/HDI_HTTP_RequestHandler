//%attributes = {}

/**
X Credentials could be generated here: https://developer.x.com/en/portal/dashboard
Google Credentials could be generated here: https://console.cloud.google.com/apis/credentials?project=
**/
var $variables:={\
PUBLIC_URL: "http://127.0.0.1"; \
X_CLIENT_ID: "RjF3blRENnA1ZE5VbEtLak84bjc6MTpjaQ"; \
X_CLIENT_SECRET: "wqosSCFwelW4PQK_2Z3TjUGUpublUXjB1NhuXc04BJB2VKU8cA"; \
X_REDIRECT_URI: "/oauth/x/callback"; \
X_AUTHORIZED_URL: "https://twitter.com/i/oauth2/authorize"; \
X_TOKEN_URL: "https://api.x.com/2/oauth2/token"; \
X_SCOPE: "users.read tweet.read"; \
X_CODE_CHALLENGE: "challenge"; \
X_CODE_CHALLENGE_METHOD: "plain"; \
X_CODE_VERIFIER: "challenge"; \
GOOGLE_CLIENT_ID: "1099057521212-ks9rfupkfr9v17hjlrak9abnee0ggs55.apps.googleusercontent.com"; \
GOOGLE_CLIENT_SECRET: "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"; \
GOOGLE_REDIRECT_URI: "/oauth/google/callback"; \
GOOGLE_AUTHORIZE_URL: "https://accounts.google.com/o/oauth2/v2/auth"; \
GOOGLE_TOKEN_URL: "https://oauth2.googleapis.com/token"; \
GOOGLE_SCOPE: "profile"; \
GOOGLE_INCLUDE_GRANTED_SCOPES: "true"; \
GOOGLE_ACCESS_TYPE: "offline"; \
GOOGLE_CODE_CHALLENGE: "code_challenge"; \
GOOGLE_CODE_CHALLENGE_METHOD: "plain"}

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
