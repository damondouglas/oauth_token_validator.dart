oauth_token_validator
=====================

# About

Validates tokens generated from Google OAuth.

# Install

```yaml
dependencies:
  oauth_token_validator:
    git: git@github.com:damondouglas/oauth_token_validator.dart.git
```

OR

```bash
$ den install -s git oauth_token_validator=git@github.com:damondouglas/oauth_token_validator.dart.git
```

# Usage

```dart
import 'package:oauth_token_validator/<console OR browser>.dart';

...
String tokenData = "ya29..." // Extracted from: Authorization: Bearer y29...
TokenInfo info = validate()
```

# Where To Acquire Token Data

## google_oauth2_client

If using [google_oauth2_client](https://pub.dartlang.org/packages/google_oauth2_client):

```dart
String tokenData = token.data; // where token is Token
```

## googleapis_auth

If using [googleapis_auth](https://pub.dartlang.org/packages/googleapis_auth):

```dart
String tokenData = token.data; // where token is AccessToken
```

## Http/REST

If redirecting to Google's OAuth 2.0 Server (see [Google Identity Platform](https://developers.google.com/identity/protocols/OAuth2WebServer)):

```dart

var response = JSON.decode(data);
var tokenData = response['access_token'];
```

# More Information

See [OAuth 2.0 Playground](https://developers.google.com/oauthplayground/) for more information.
