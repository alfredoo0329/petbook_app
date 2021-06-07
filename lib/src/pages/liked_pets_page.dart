import 'package:flutter/material.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/providers/firepets_provider.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:petbook_app/src/utils/utils.dart';
import 'package:petbook_app/src/widgets/pet_swiper_widget.dart';
import 'package:provider/provider.dart';

class LikedPetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PetfinderProvider _petfinder = Provider.of<PetfinderProvider>(context);

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
      leading: IconButton(
        icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
        onPressed: () {
          FirepetsProvider firepetsProvider =
              Provider.of<FirepetsProvider>(context, listen: false);
          firepetsProvider.email = null;
          firepetsProvider.key = '';
          Navigator.of(context).pop();
        },
      ),
      title: Image(
        image: AssetImage('assets/images/logotype.png'),
        height: 30,
        fit: BoxFit.cover,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Icon(
            Icons.star_rate_rounded,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
        )
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
              text: 'Pets ',
              style: TextStyle(
                fontSize: 28,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                    text: 'Liked\n',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                TextSpan(text: ' By You.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _nothing() {}

  Widget _getCardSwiper(BuildContext context) {
    List<Pet> petList;
    return FutureBuilder(
      future: getPets(context),
      builder: (context, snapshot) {
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

        return Expanded(
          child: PetSwiper(pets: snapshot.data, nextPage: _nothing),
        );
      },
    );
  }
}
