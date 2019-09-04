import 'package:flutter/foundation.dart';
import '../app.dart';
import 'dongey_api_provider.dart';
import '../models/jwt_request.dart';


class UserRepository {

  final dongeyApiProvider = UserApiProvider();
  Future<String> authenticate({
    @required String email,
    @required String password,
  }) => dongeyApiProvider.getToken(
      jwtRequest: JwtRequest(
          password: password,
          email: email)
  );

  Future<void> deleteToken() async {
    await CustomerInfo().storage.delete(key: 'token');
    return;
  }
  Future<bool> hasToken() async {
    var userStorage = CustomerInfo().storage;
    return await userStorage.read(key: 'token') != null;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await CustomerInfo().storage.write(key: 'token', value: token);
    return;
  }

  Future<String> getLocalToken() async {
    /// read from keystore/keychain
    var userStorage = CustomerInfo().storage;
    String token = await userStorage.read(key: 'token');

    return token;
  }
}
