import 'package:flutter/material.dart' show Widget, BuildContext;
import 'package:petbook_app/src/pages/image_view_page.dart';
import 'package:petbook_app/src/pages/map_view_page.dart';
import 'package:petbook_app/src/pages/organization_details_page.dart';
import 'package:petbook_app/src/pages/organizations_page.dart';
import 'package:petbook_app/src/pages/pet_details_page.dart';
import 'package:petbook_app/src/pages/pet_filter.dart';
import 'package:petbook_app/src/pages/pets_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes() {
  return {
    '/': (BuildContext context) => PetsPage(),
    'pet': (BuildContext context) => PetDetailsPage(),
    'organizations': (BuildContext context) => OrganizationsPage(),
    'organization': (BuildContext context) => OrganizationDetailsPage(),
    'image': (BuildContext context) => ImageViewPage(),
    'map': (BuildContext context) => MapView(),
    'petFilter': (BuildContext context) => PetFilter()
  };
}
