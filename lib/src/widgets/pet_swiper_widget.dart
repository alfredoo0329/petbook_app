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
    int heroPosition = 0;

    if (pets.length == 1) {
      pets[0].uniqueIdImage = '${pets[0].id}-imageS';
      pets[0].uniqueIdTopTitle = '${pets[0].id}-titleS';
      pets[0].uniqueIdTitle = '${pets[0].id}-topTitleS';
      pets[0].uniqueIdTags = '${pets[0].id}-tagsS';
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'pet', arguments: pets[0]);
        },
        child: Container(width: 320, child: PetCard(pet: pets[0])),
      );
    }

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
        onTap: (pos) {
          Navigator.pushNamed(context, 'pet', arguments: pets[pos]);
        },
        itemBuilder: (BuildContext context, int pos) {
          heroPosition++;
          pets[pos].uniqueIdImage = '$heroPosition-${pets[pos].id}-image';
          pets[pos].uniqueIdTopTitle = '$heroPosition-${pets[pos].id}-title';
          pets[pos].uniqueIdTitle = '$heroPosition-${pets[pos].id}-topTitle';
          pets[pos].uniqueIdTags = '$heroPosition-${pets[pos].id}-tags';
          return PetCard(pet: pets[pos]);
        },
        onIndexChanged: (index) {
          if (index >= pets.length - 6) nextPage();
        },
      ),
    );
  }
}
