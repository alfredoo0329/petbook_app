import 'package:flutter/material.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:petbook_app/src/widgets/pet_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PetfinderProvider _petfinder = PetfinderProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFF7043),
        textTheme: TextTheme(
          headline1: TextStyle(fontFamily: 'JetBrains Mono'),
          headline2: TextStyle(fontFamily: 'JetBrains Mono'),
          bodyText1: TextStyle(fontFamily: 'JetBrains Mono'),
          bodyText2: TextStyle(fontFamily: 'JetBrains Mono'),
        ),
      ),
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('PetBook',
              style: TextStyle(
                  fontFamily: 'JetBrains Mono', fontWeight: FontWeight.w700)),
        ),
        body: FutureBuilder(
          future: _petfinder.getPets(),
          builder: (context, snaptshot) {
            if (!snaptshot.hasData) return Center();
            List<Pet> pets = snaptshot.data;
            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (_, i) {
                return PetCard(
                  name: pets[i].name,
                  age: pets[i].age,
                  breed: pets[i].breeds.primary,
                  size: pets[i].size,
                  gender: pets[i].gender,
                  imageUrl: pets[i].photos.isNotEmpty
                      ? pets[i].photos.first.medium
                      : "",
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next_rounded),
          onPressed: () {},
        ),
      ),
    );
  }
}
