import 'package:flutter/material.dart' show Widget, BuildContext;
import 'package:petbook_app/src/pages/pets_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes() {
  return {'/': (BuildContext context) => PetsPage()};
}