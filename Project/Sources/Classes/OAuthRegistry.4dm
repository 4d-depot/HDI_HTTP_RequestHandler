

property store : Object:={}


Class constructor()
	
	var $publicUrl:=ds:C1482.Settings.getKey("PUBLIC_URL")
	
	This:C1470.register("twitter"; \
		{\
		authorizeUrl: ds:C1482.Settings.getKey("X_AUTHORIZED_URL"); \
		tokenUrl: ds:C1482.Settings.getKey("X_TOKEN_URL"); \
		clientId: ds:C1482.Settings.getKey("X_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("X_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("X_REDIRECT_URI"); \
		scope: ds:C1482.Settings.getKey("X_SCOPE")}; \
		{code_challenge: ds:C1482.Settings.getKey("X_CODE_CHALLENGE"); code_challenge_method: ds:C1482.Settings.getKey("X_CODE_CHALLENGE_METHOD")}; \
		{code_verifier: ds:C1482.Settings.getKey("X_CODE_VERIFIER")}\
		)
	
	
	This:C1470.register("google"; \
		{\
		authorizeUrl: ds:C1482.Settings.getKey("GOOGLE_AUTHORIZE_URL"); \
		tokenUrl: ds:C1482.Settings.getKey("GOOGLE_TOKEN_URL"); \
		clientId: ds:C1482.Settings.getKey("GOOGLE_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("GOOGLE_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("GOOGLE_REDIRECT_URI"); \
		scope: ds:C1482.Settings.getKey("GOOGLE_SCOPE")}; \
		{include_granted_scopes: ds:C1482.Settings.getKey("GOOGLE_INCLUDE_GRANTED_SCOPES"); access_type: ds:C1482.Settings.getKey("GOOGLE_ACCESS_TYPE")}; \
		{code_challenge: ds:C1482.Settings.getKey("GOOGLE_CODE_CHALLENGE"); code_challenge_method: ds:C1482.Settings.getKey("GOOGLE_CODE_CHALLENGE_METHOD")}\
		)
	
	
shared Function register($strategy : Text; $options : Object; $authOptions : Object; $tokenOptions : Object)
	This:C1470.store[$strategy]:=cs:C1710.OAuthStrategy.new($strategy; $options; $authOptions; $tokenOptions)
	
Function get($name : Text) : cs:C1710.OAuthStrategy
	return This:C1470.store[$name]
	