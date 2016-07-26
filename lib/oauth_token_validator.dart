library oauth_token_validator;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final BASE_URL = "https://www.googleapis.com/oauth2/v3/tokeninfo";

/// returns [TokenInfo] acquired from googleapis.com from the [tokenData].
Future<TokenInfo> validate(String tokenData) => new Future(() async {
  var config = new Config(tokenData);
  var response = await http.get(config.uri.toString(), headers: {
    'Content-Type': 'application/json'
  });
  Map body = JSON.decode(response.body);
  if (body.containsKey('error_description')) throw new Exception("Token is not valid or expired.");
  var info = new TokenInfo.from(body);
  return info;
});

/// Builds a Uri based on [tokenData].
class Config {
  String tokenData;
  Config(this.tokenData);
  Uri get uri => Uri.parse("$BASE_URL?access_token=$tokenData");
}

/// Stores data about the authentication.
class TokenInfo {
  String clientId;
  List<String> scope;
  DateTime expiration;
  Duration expiresIn;
  String email;
  bool emailVerified;
  String accessType;
  bool get expired => new DateTime.now().isAfter(expiration);

  TokenInfo();

  TokenInfo.from(Map json) {
    clientId = json['azp'];
    scope = json['scope'].split(' ');
    var expiresInSeconds = int.parse(json['expires_in'], onError: (input) => -1);
    var expiresInDuration = new Duration(seconds: expiresInSeconds);
    expiration = new DateTime.now().add(expiresInDuration);
    expiresIn = expiresInDuration;
    email = json['email'];
    emailVerified = json['email_verified'] == "true";
    accessType = json['access_type'];
  }
}
