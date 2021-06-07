import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  final String _apiKey = 'AIzaSyB2WMxagKQLzvXmyOelEo9ODyM5UjxEXFk';
  final String _registerUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
  final String _signInUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';

  String _token;
  int _tokenTime;

  final int EMAIL_NOT_FOUND = -1;
  final int INVALID_PASSWORD = -2;
  final int WHO_KNOWS = -3;

  Future<dynamic> _postRequest(
      Uri url, Map<String, String> header, dynamic body) async {
    final response = await http.post(url, headers: header, body: body);
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<bool> registrarUsuario(String email, String password) async {
    final url = Uri.parse('$_registerUrl?key=$_apiKey');
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    };
    final result = await _postRequest(url, {}, body);

    if (result['idToken'] == null) return false;
    _token = result['idToken'];
    return true;
  }

  Future<int> ingresarUsuario(String email, String password) async {
    final url = Uri.parse('$_signInUrl?key=$_apiKey');
    final body = {
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    };
    final result = await _postRequest(url, {}, body);

    if (result['idToken'] != null) {
      _token = result['idToken'];
      return 1;
    }

    if (result['error']['message'] == 'EMAIL_NOT_FOUND') return EMAIL_NOT_FOUND;
    if (result['error']['message'] == 'INVALID_PASSWORD')
      return INVALID_PASSWORD;
    return WHO_KNOWS;
  }
}
