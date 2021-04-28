import 'dart:convert';
import 'package:petbook_flutter/src/models/pet_model.dart';
import 'package:petbook_flutter/src/models/pets_model.dart';
import 'package:petbook_flutter/src/models/token_model.dart';
import 'package:http/http.dart' as http;

class PetfinderProvider {
  final String _apiKey = 'ahUgGiYEyy94iCZoPBoK9JeKQ3DU1tiP0Ca86m9XfKRe0TpKUP';
  final String _apiSecret = 'Jzo7VWHWp4CdpJqB0pzJJz6A0GrypneSX4bIA2jU';
  final String _domain = 'api.petfinder.com';
  Token _token;
  Pagination _pagination;

  Future<dynamic> _postRequest(
      Uri url, Map<String, String> header, dynamic body) async {
    final response = await http.post(url, headers: header, body: body);
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<dynamic> _getRequest(Uri url, Map<String, String> header) async {
    final response = await http.get(url, headers: header);
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<Token> getToken() async {
    final url = Uri.https(_domain, 'v2/oauth2/token');
    final body = {
      'grant_type': 'client_credentials',
      'client_id': _apiKey,
      'client_secret': _apiSecret
    };
    final decodedData = await _postRequest(url, {}, body);
    _token = Token.fromJsonMap(decodedData);
    return _token;
  }

  Future<List<Pet>> getPets() async {
    if (_token == null) await getToken();
    final body = {'page': '4'};
    final url = Uri.https(_domain, 'v2/animals', body);
    final header = {
      'Authorization': '${_token.tokenType} ${_token.accessToken}'
    };
    final decodedData = await _getRequest(url, header);
    final pets = Pets.fromJson(decodedData);
    _pagination = pets.pagination;
    return pets.pets;
  }
}
