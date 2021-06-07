import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:petbook_app/src/models/pet_model.dart';

class FirepetsProvider extends ChangeNotifier {
  final String _url = 'https://petbook-1d7f7-default-rtdb.firebaseio.com/';

  String email;
  String key = '';

  Future getKey() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/favorites.json';
    final resp = await http.get(Uri.parse(url));
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    decodedData.forEach((key, value) {
      final String data = value['user'];
      if (data.compareTo(email) == 0) {
        this.key = key;
        return;
      }
    });
  }

  Future<List<dynamic>> getPets() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    if (key == '') await getKey();
    if (key == '') return [];
    final url = '$_url/favorites/$key.json';
    final response = await http.get(Uri.parse(url));
    final Map<String, dynamic> decodedData = json.decode(response.body);
    return decodedData['pets'];
  }

  Future<bool> saveLikedPet(Pet pet) async {
    // https://petbook-1d7f7-default-rtdb.firebaseio.com/favoritePets
    if (key == '') await getKey();

    String url = '$_url/favorites.json';

    if (key != '') url = '$_url/favorites/$key.json';

    List<dynamic> petList = await getPets();
    petList.add(pet.id);

    final data = {'user': '$email', 'pets': petList};

    dynamic response, decodedData;
    if (key != '')
      response = await http.put(Uri.parse(url), body: json.encode(data));
    else
      response = await http.post(Uri.parse(url), body: json.encode(data));

    decodedData = json.decode(response.body);
    if (decodedData['error'] == null) return true;
    return false;
  }

  /*Future<bool> modificarProducto(ProductoModel producto) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/productos/${producto.id}.json';

    final resp =
        await http.put(Uri.parse(url), body: productoModelToJson(producto));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }*/

  /*Future<int> eliminarProducto(String id) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos/-MZAnaCf9nB3i3TnDByL.json
    final url = '$_url/productos/$id.json';

    final resp = await http.delete(Uri.parse(url));
    print(json.decode(resp.body)); // null

    return -1;
  }

  Future<String> subirImagen(File image) async {
    final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/dqe07m4dr/image/upload?upload_preset=z41jqxvk');
    List<String> mimeType = mime(image.path).split('/'); // imagen/jpg

    // request para adjuntar imagen
    final imageUploadRequest = http.MultipartRequest('POST', uri);

    // crear archivo para adjuntar
    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType.first, mimeType.last),
    );

    // adjuntar archivo
    imageUploadRequest.files.add(file);

    // enviar request
    final streamResponse = await imageUploadRequest.send();
    // obtener respuesta
    final resp = await http.Response.fromStream(streamResponse);

    // validar codigo de respuesta
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);

    return respData['secure_url'];
  }*/
}
