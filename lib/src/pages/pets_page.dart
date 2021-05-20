import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:petbook_app/src/widgets/bottom_nav_bar_widget.dart';
import 'package:petbook_app/src/widgets/pet_swiper_widget.dart';

class PetsPage extends StatefulWidget {
  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  final PetfinderProvider _petfinder = PetfinderProvider();

  @override
  Widget build(BuildContext context) {
    _petfinder.getPets();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fondoPET.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              getTitle(context),
              getCardSwiper(context),
              BotttomNavbar(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      titleSpacing: 18,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image(
        image: AssetImage('assets/images/logotype.png'),
        height: 30,
        fit: BoxFit.cover,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: FaIcon(
            FontAwesomeIcons.solidUserCircle,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
        )
      ],
    );
  }

  Widget getTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Find Your\nBest ',
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                    text: 'Friend',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCardSwiper(BuildContext context) {
    return StreamBuilder(
      stream: _petfinder.petsStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Column(
                children: [
                  Text('Something went wrong'),
                  ElevatedButton(
                      onPressed: () {
                        _petfinder.getPets();
                      },
                      child: Text('Try Again'))
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData)
          return Container(
            child: Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ),
          );

        if (snapshot.data.isEmpty) {
          return Container(
            child: Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something went wrong'),
                    ElevatedButton(
                        onPressed: () {
                          _petfinder.getPets();
                        },
                        child: Text('Try Again'))
                  ],
                ),
              ),
            ),
          );
        }

        return Expanded(
          child: PetSwiper(pets: snapshot.data, nextPage: _petfinder.getPets),
        );
      },
    );
  }
}
