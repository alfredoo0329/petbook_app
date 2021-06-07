import 'package:flutter/material.dart';
import 'package:petbook_app/src/icon_models/pet_icons.dart';
import 'package:petbook_app/src/providers/firepets_provider.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:petbook_app/src/widgets/bottom_nav_bar_widget.dart';
import 'package:petbook_app/src/widgets/pet_swiper_widget.dart';
import 'package:provider/provider.dart';

class PetsPage extends StatefulWidget {
  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  PetfinderProvider _petfinder;

  @override
  Widget build(BuildContext context) {
    _petfinder = Provider.of<PetfinderProvider>(context);
    _petfinder.getPets();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppBar(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/fondoPET.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              _getTitle(context),
              _getCardSwiper(context),
              BottomNavbar(selected: 2),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      titleSpacing: 18,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 0,
      leading: Container(),
      title: Image(
        image: AssetImage('assets/images/logotype.png'),
        height: 30,
        fit: BoxFit.cover,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
          onPressed: () {
            FirepetsProvider firepetsProvider =
                Provider.of<FirepetsProvider>(context, listen: false);
            firepetsProvider.email = null;
            firepetsProvider.key = '';
            Navigator.of(context).pop();
          },
        ),
        IconButton(
            icon: Icon(
              Icons.star_rate_rounded,
              color: Theme.of(context).primaryColor,
              size: 28,
            ),
            onPressed: () {
              //Navigator.pushNamed(context, 'liked');
            })
      ],
    );
  }

  Widget _getTitle(BuildContext context) {
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
                fontWeight: FontWeight.w700,
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

  Widget _getCardSwiper(BuildContext context) {
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
                    Icon(PetIcons.notfound,
                        size: 144, color: Theme.of(context).primaryColor),
                    Text(
                      'No Pet Found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    Text(
                      'Unfortunately we couldn´t find your friend',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
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
