import 'package:flutter/material.dart';
import 'package:petbook_flutter/src/models/pet_model.dart';
import 'package:petbook_flutter/src/providers/petfinder_provider.dart';

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
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: FutureBuilder(
          future: _petfinder.getPets(),
          builder: (context, snaptshot) {
            if (!snaptshot.hasData) return Center();
            List<Pet> pets = snaptshot.data;
            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (_, i) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pets[i].photos.isNotEmpty
                        ? pets[i].photos[0].small
                        : 'https://icon-library.com/images/no-image-icon/no-image-icon-12.jpg'),
                  ),
                  title: Text(pets[i].name),
                  trailing: Text(pets[i].age),
                  subtitle: Text(
                      pets[i].description != null ? pets[i].description : ''),
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
