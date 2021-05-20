import 'package:flutter/material.dart';

class BotttomNavbar extends StatefulWidget {
  @override
  _BotttomNavbarState createState() => _BotttomNavbarState();
}

class _BotttomNavbarState extends State<BotttomNavbar> {
  int selected = 2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 16),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return AnimatedContainer(
                curve: Curves.easeInOutSine,
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.only(
                    top: 5,
                    left: 5.0 +
                        (selected - 1.0) * ((constraints.maxWidth - 15) / 3)),
                width: constraints.maxWidth / 3,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              );
            },
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Tooltip(
                    message: 'Shelters',
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      icon: Icon(Icons.home,
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
                        setState(() {
                          selected = 2;
                        });
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
                      onPressed: () {
                        setState(() {
                          selected = 3;
                        });
                      },
                      icon: Icon(Icons.search,
                          color: selected == 3
                              ? Theme.of(context).primaryColor
                              : Colors.white),
                      iconSize: selected == 3 ? 28 : 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
