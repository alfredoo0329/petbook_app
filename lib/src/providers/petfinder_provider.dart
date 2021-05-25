import 'dart:async';
import 'dart:convert';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/models/pet_types_model.dart';
import 'package:petbook_app/src/models/pets_model.dart';
import 'package:petbook_app/src/models/token_model.dart';
import 'package:http/http.dart' as http;

class PetfinderProvider {
  //CONFIGURATION
  final String _apiKey = 'ahUgGiYEyy94iCZoPBoK9JeKQ3DU1tiP0Ca86m9XfKRe0TpKUP';
  final String _apiSecret = 'Jzo7VWHWp4CdpJqB0pzJJz6A0GrypneSX4bIA2jU';
  final String _domain = 'api.petfinder.com';

  //PETS DATA STORAGE VARIABLES
  Token _token;
  Pets _pets;

  //STREAM CONTROLLER FUNCTIONS
  final _petsStreamController = StreamController<List<Pet>>.broadcast();
  Function(List<Pet>) get petsSink => _petsStreamController.sink.add;
  Stream<List<Pet>> get petsStream => _petsStreamController.stream;
  void disposeStream() => _petsStreamController.close();
  bool _loadingStream = false;

  //REQUIESTS POST & GET
  Future<dynamic> _postRequest(
      Uri url, Map<String, String> header, dynamic body) async {
    final response = await http.post(url, headers: header, body: body);
    if (response.statusCode >= 400) return -1;
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  Future<dynamic> _getRequest(Uri url, Map<String, String> header) async {
    final response = await http.get(url, headers: header);
    final decodedData = json.decode(response.body);
    return decodedData;
  }

  //METODS
  Future getToken() async {
    if (_token != null) return;

    final url = Uri.https(_domain, 'v2/oauth2/token');
    final body = {
      'grant_type': 'client_credentials',
      'client_id': _apiKey,
      'client_secret': _apiSecret
    };
    dynamic decodedData;
    try {
      decodedData = await _postRequest(url, {}, body);
    } catch (_) {
      return null;
    }

    _token = Token.fromJsonMap(decodedData);
  }

  Future<List<Pet>> getPets() async {
    //IS LOADING CHECK---------------------------

    if (_loadingStream) return [];
    _loadingStream = true;

    //GET TOKEN---------------------------

    await getToken();
    if (_token == null) {
      if (_pets == null) {
        petsSink([]);
        _loadingStream = false;
        return [];
      }
      petsSink(_pets.petList);
      _loadingStream = false;
      return _pets.petList;
    }

    //SEND REQUEST---------------------------

    Map<String, dynamic> body = {'type': 'Horse'};
    if (_pets != null)
      body = {'page': '${_pets.pagination.currentPage + 1}', 'type': 'Horse'};

    final url = Uri.https(_domain, 'v2/animals', body);
    final header = {
      'Authorization': '${_token.tokenType} ${_token.accessToken}'
    };

    //CHECK DECODED DATA---------------------------

    dynamic decodedData;
    try {
      decodedData = await _getRequest(url, header);
    } catch (_) {
      if (_pets == null) {
        petsSink([]);
        _loadingStream = false;
        return [];
      }
      petsSink(_pets.petList);
      _loadingStream = false;
      return _pets.petList;
    }

    //GET DATA AND UPDATE STREAM---------------------------

    final newPets = Pets.fromJson(decodedData);

    if (_pets == null) {
      _pets = newPets;
      petsSink(_pets.petList);

      _loadingStream = false;
      return _pets.petList;
    }

    _pets.petList.addAll(newPets.petList);
    _pets.pagination = newPets.pagination;
    petsSink(_pets.petList);

    _loadingStream = false;
    return _pets.petList;
  }

  Future<List<String>> getTypes() async {
    if (_token == null) await getToken();

    final url = Uri.https(_domain, 'v2/types', {});
    final header = {
      'Authorization': '${_token.tokenType} ${_token.accessToken}'
    };
    final decodedData = await _getRequest(url, header);
    final petTypes = PetTypes.fromJson(decodedData);

    List<String> petTypesList = [];
    petTypes.types.forEach((type) {
      petTypesList.add(type.name);
    });
    return petTypesList;
  }
}
