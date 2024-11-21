

Class constructor()
	
	var $publicUrl:=ds:C1482.Settings.getKey("PUBLIC_URL")
	
	This:C1470.store:={}
	
	This:C1470.register("twitter"; \
		{\
		authorizeUrl: "https://twitter.com/i/oauth2/authorize"; \
		tokenUrl: "https://api.x.com/2/oauth2/token"; \
		clientId: ds:C1482.Settings.getKey("X_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("X_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("X_REDIRECT_URI"); \
		scope: "users.read tweet.read"}; \
		{code_challenge: "challenge"; code_challenge_method: "plain"}; \
		{code_verifier: "challenge"}\
		)
	
	
	This:C1470.register("google"; \
		{\
		authorizeUrl: "https://accounts.google.com/o/oauth2/v2/auth"; \
		tokenUrl: "https://oauth2.googleapis.com/token"; \
		clientId: ds:C1482.Settings.getKey("GOOGLE_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("GOOGLE_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("GOOGLE_REDIRECT_URI"); \
		scope: "profile"}; \
		{include_granted_scopes: "true"; access_type: "offline"}; \
		{code_challenge: "challenge"; code_challenge_method: "plain"}\
		)
	
	
	// https://learn.microsoft.com/en-us/entra/identity-platform/v2-protocols-oidc#protocol-diagram-access-token-acquisition
	This:C1470.register("microsoft"; \
		{\
		authorizeUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"; \
		tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token"; \
		clientId: ds:C1482.Settings.getKey("MICROSOFT_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("MICROSOFT_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("MICROSOFT_REDIRECT_URI"); \
		scope: "User.Read"}; {}; {})
	
	
	// https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps
	This:C1470.register("github"; \
		{\
		authorizeUrl: "https://github.com/login/oauth/authorize"; \
		tokenUrl: "https://github.com/login/oauth/access_token"; \
		clientId: ds:C1482.Settings.getKey("GITHUB_CLIENT_ID"); \
		clientSecret: ds:C1482.Settings.getKey("GITHUB_CLIENT_SECRET"); \
		redirectUri: $publicUrl+ds:C1482.Settings.getKey("GITHUB_REDIRECT_URI"); \
		scope: ""}; {allow_signup: "true"}; {}\
		)
	
	
shared Function register($strategy : Text; $options : Object; $authOptions : Object; $tokenOptions : Object)
	This:C1470.store[$strategy]:=cs:C1710.OAuthStrategy.new($strategy; $options; $authOptions; $tokenOptions)
	
Function get($name : Text) : cs:C1710.OAuthStrategy
	return This:C1470.store[$name]
	