import 'package:flutter/material.dart';
import 'package:petbook_app/src/models/organization_model.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/providers/firepets_provider.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:provider/provider.dart';

getInfoFromDecodedData(Map<String, dynamic> decodedData) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(decodedData.toString())
      .forEach((match) => print(match.group(0)));
}

String getImageByType(String type) {
  switch (type) {
    case 'Dog':
      return 'assets/images/NoDog.jpg';
    case 'Cat':
      return 'assets/images/NoCat.jpg';
    case 'Rabbit':
      return 'assets/images/NoRabbit.jpg';
    case 'Small & Furry':
      return 'assets/images/NoSmall.jpg';
    case 'Horse':
      return 'assets/images/NoHorse.jpg';
    case 'Bird':
      return 'assets/images/NoBird.jpg';
    case 'Scales, Fins & Other':
      return 'assets/images/NoScales.jpg';
    case 'Barnyard':
      return 'assets/images/NoBarnyard.jpg';
    default:
      return 'assets/images/NoOther.jpg';
  }
}

getTimeString(Hours time) {
  if (time.monday == null) return 'Time No Available';
  final DateTime today = DateTime.now();
  switch (today.weekday) {
    case 1:
      if (time.monday == 'Closed') return time.monday;
      return 'MONDAY ${time.monday}';
    case 2:
      if (time.tuesday == 'Closed') return time.tuesday;
      return 'TUESDAY ${time.tuesday}';
    case 3:
      if (time.wednesday == 'Closed') return time.wednesday;
      return 'WEDNESDAY ${time.wednesday}';
    case 4:
      if (time.thursday == 'Closed') return time.thursday;
      return 'THURSDAY ${time.thursday}';
    case 5:
      if (time.friday == 'Closed') return time.friday;
      return 'FRIDAY ${time.friday}';
    case 6:
      if (time.saturday == 'Closed') return time.saturday;
      return 'SATURDAY ${time.saturday}';
    case 7:
      if (time.sunday == 'Closed') return time.sunday;
      return 'SUNDAY ${time.sunday}';
  }
}

List<Pet> removeRepeated(List<int> oldPets, List<Pet> newPets) {
  List<int> removePositions = [];
  for (int i = 0; i < newPets.length; i++)
    for (int id in oldPets) if (newPets[i].id == id) removePositions.add(i);
  removePositions = removePositions.reversed.toList();
  removePositions.forEach((i) => newPets.removeAt(i));
  return newPets;
}

Future<List<Pet>> getPets(BuildContext context) async {
  FirepetsProvider firepets = Provider.of<FirepetsProvider>(context);
  PetfinderProvider petfinder = Provider.of<PetfinderProvider>(context);

  final petIds = await firepets.getPets();
  final petList = await petfinder.getPetsById(petIds);
  return petList;
}
