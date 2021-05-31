import 'dart:async';
import 'dart:convert';
import 'package:petbook_app/src/models/organization_model.dart';
import 'package:petbook_app/src/models/organizations_model.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/models/pets_model.dart';
import 'package:petbook_app/src/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:petbook_app/src/utils/utils.dart';

class PetfinderProvider {
  //CONFIGURATION
  final String _apiKey = 'ahUgGiYEyy94iCZoPBoK9JeKQ3DU1tiP0Ca86m9XfKRe0TpKUP';
  final String _apiSecret = 'Jzo7VWHWp4CdpJqB0pzJJz6A0GrypneSX4bIA2jU';
  final String _domain = 'api.petfinder.com';

  //PETS DATA STORAGE VARIABLES
  Token _token;
  Pets _pets;
  Organizations _organizations;

  //STREAM CONTROLLER FUNCTIONS
  final _petsStreamController = StreamController<List<Pet>>.broadcast();
  Function(List<Pet>) get petsSink => _petsStreamController.sink.add;
  Stream<List<Pet>> get petsStream => _petsStreamController.stream;
  void disposePetsStream() => _petsStreamController.close();
  bool _loadingPetsStream = false;

  final _organizationsStreamController =
      StreamController<List<Organization>>.broadcast();
  Function(List<Organization>) get organizationsSink =>
      _organizationsStreamController.sink.add;
  Stream<List<Organization>> get organizationsStream =>
      _organizationsStreamController.stream;
  void disposeOrganizationsStream() => _organizationsStreamController.close();
  bool _loadingOrganizationsStream = false;

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

    if (_loadingPetsStream) return [];
    _loadingPetsStream = true;

    //GET TOKEN---------------------------

    await getToken();
    if (_token == null) {
      if (_pets == null) {
        petsSink([]);
        _loadingPetsStream = false;
        return [];
      }
      petsSink(_pets.petList);
      _loadingPetsStream = false;
      return _pets.petList;
    }

    //SEND REQUEST---------------------------

    Map<String, dynamic> body = {};
    if (_pets != null) body = {'page': '${_pets.pagination.currentPage + 1}'};

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
        _loadingPetsStream = false;
        return [];
      }
      petsSink(_pets.petList);
      _loadingPetsStream = false;
      return _pets.petList;
    }

    //GET DATA AND UPDATE STREAM---------------------------

    final newPets = Pets.fromJson(decodedData);

    if (_pets == null) {
      _pets = newPets;
      petsSink(_pets.petList);
      _loadingPetsStream = false;
      return _pets.petList;
    }

    newPets.petList = removeRepeated(_pets.getIdList(), newPets.petList);

    _pets.petList.addAll(newPets.petList);
    _pets.pagination = newPets.pagination;
    petsSink(_pets.petList);

    _loadingPetsStream = false;
    return _pets.petList;
  }

  Future<List<Organization>> getOrganizations() async {
    //IS LOADING CHECK---------------------------

    if (_loadingOrganizationsStream) return [];
    _loadingOrganizationsStream = true;

    //GET TOKEN---------------------------

    await getToken();
    if (_token == null) {
      if (_organizations == null) {
        organizationsSink([]);
        _loadingOrganizationsStream = false;
        return [];
      }
      organizationsSink(_organizations.organizationList);
      _loadingOrganizationsStream = false;
      return _organizations.organizationList;
    }

    //SEND REQUEST---------------------------

    Map<String, dynamic> body = {};
    if (_organizations != null)
      body = {'page': '${_organizations.pagination.currentPage + 1}'};

    final url = Uri.https(_domain, 'v2/organizations', body);
    final header = {
      'Authorization': '${_token.tokenType} ${_token.accessToken}'
    };

    //CHECK DECODED DATA---------------------------

    dynamic decodedData;
    try {
      decodedData = await _getRequest(url, header);
    } catch (_) {
      if (_organizations == null) {
        organizationsSink([]);
        _loadingOrganizationsStream = false;
        return [];
      }
      organizationsSink(_organizations.organizationList);
      _loadingOrganizationsStream = false;
      return _organizations.organizationList;
    }

    //GET DATA AND UPDATE STREAM---------------------------

    final newOrganizations = Organizations.fromJson(decodedData);

    if (_organizations == null) {
      _organizations = newOrganizations;
      organizationsSink(_organizations.organizationList);
      _loadingOrganizationsStream = false;
      return _organizations.organizationList;
    }

    _organizations.organizationList.addAll(newOrganizations.organizationList);
    _organizations.pagination = newOrganizations.pagination;
    organizationsSink(_organizations.organizationList);

    _loadingOrganizationsStream = false;
    return _organizations.organizationList;
  }
}
