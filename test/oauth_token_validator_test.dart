import 'package:test/test.dart';
import 'package:oauth_token_validator/oauth_token_validator.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

String tokenData;

main(List<String> args) {
  if (args.length == 0) {
    print("Usage: oauth_token_validator_test.dart <oauth_token>");
    exit(1);
  }

  setUp(() {
    tokenData = args[0];
  });

  test('', () async {
    var info = await validate(tokenData);
    expect(info.expired, false);
    expect(info.clientId, isNotNull);
    expect(info.email, isNotNull);
    expect(info.emailVerified, true);
  });
}
