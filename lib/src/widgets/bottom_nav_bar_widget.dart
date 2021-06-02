import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petbook_app/src/icon_models/pet_icons.dart';

class BottomNavbar extends StatelessWidget {
  final int selected;

  const BottomNavbar({this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 16),
      child: Stack(
        children: [
          Hero(
            tag: "bootomNavBackground",
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          Hero(
            tag: "bootomNavActive",
            child: Material(
              type: MaterialType.transparency,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 5,
                        left: 5.0 +
                            (selected - 1.0) *
                                ((constraints.maxWidth - 15) / 3)),
                    width: constraints.maxWidth / 3,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  );
                },
              ),
            ),
          ),
          Hero(
            tag: "bootomNavIcons",
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: 'Shelters',
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, 'organizations');
                          },
                          icon: Icon(FontAwesomeIcons.home,
                              color: selected == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                          iconSize: selected == 1 ? 28 : 24,
                        ),
                      ),
                      Tooltip(
                        message: 'Pets',
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          icon: Icon(Icons.pets,
                              color: selected == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                          iconSize: selected == 2 ? 28 : 24,
                        ),
                      ),
                      Tooltip(
                        message: 'Search',
                        child: IconButton(
                          onPressed: () async {
                            /*await Provider.of<PetfinderProvider>(context,
                                    listen: false)
                                .resetPetsStream();*/
                            if (selected == 2) {
                              Navigator.pushNamed(context, 'petFilter');
                              return;
                            }
                            //Navigator.pushNamed(context, routeName)
                          },
                          icon: Icon(
                              selected == 1
                                  ? PetIcons.searchShelter
                                  : PetIcons.searchPet,
                              color: Colors.white),
                          iconSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
