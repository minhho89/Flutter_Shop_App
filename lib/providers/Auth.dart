import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_nojson/consts/constants.dart';
import 'package:shop_app_nojson/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;

  bool isAuth() {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=${webApiKey}');

    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);

      // TODO: DEBUG
      print(response.statusCode);
      var extractedData = json.decode(response.body);

      _token = extractedData['idToken'];
      _userId = extractedData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(extractedData['expiresIn']),
        ),
      );

      print(extractedData['idToken']);
      print(extractedData['email']);

      if (responseData['error'] != null) {
        print(responseData['error']);
        throw HttpException(responseData['error']['message']);
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }
}
