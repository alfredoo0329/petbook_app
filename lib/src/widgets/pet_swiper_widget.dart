import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/widgets/pet_card.dart';

class PetSwiper extends StatelessWidget {
  final List<Pet> pets;
  final Function nextPage;

  PetSwiper({@required this.pets, @required this.nextPage});

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Swiper(
        loop: false,
        itemCount: pets.length,
        itemWidth: 320,
        controller: _swiperController,
        layout: SwiperLayout.STACK,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int pos) {
          return PetCard(pet: pets[pos]);
        },
        onIndexChanged: (index) {
          if (index >= pets.length - 6) nextPage();
        },
      ),
    );
  }
}