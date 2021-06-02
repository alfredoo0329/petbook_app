import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:petbook_app/src/models/organization_model.dart';
import 'organization_card.dart';

class OrganizationSwiper extends StatelessWidget {
  final List<Organization> organizations;
  final Function nextPage;

  OrganizationSwiper({@required this.organizations, @required this.nextPage});

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    int heroPosition = 0;

    if (organizations.length == 1) {
      organizations[0].uniqueIdImage = '${organizations[0].id}-imageS';
      organizations[0].uniqueIdTopTitle = '${organizations[0].id}-topTitleS';
      organizations[0].uniqueIdTitle = '${organizations[0].id}-titleS';
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'organization',
              arguments: organizations[0]);
        },
        child: Container(
            width: 320,
            child: OrganizationCard(organization: organizations[0])),
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Swiper(
        loop: false,
        itemCount: organizations.length,
        itemWidth: 320,
        controller: _swiperController,
        layout: SwiperLayout.STACK,
        physics: ScrollPhysics(),
        onTap: (pos) {
          Navigator.pushNamed(context, 'organization',
              arguments: organizations[pos]);
        },
        itemBuilder: (BuildContext context, int pos) {
          organizations[pos].uniqueIdImage =
              '$heroPosition-${organizations[pos].id}-image';
          organizations[pos].uniqueIdTitle =
              '$heroPosition-${organizations[pos].id}-title';
          organizations[pos].uniqueIdTopTitle =
              '$heroPosition-${organizations[pos].id}-topTitle';
          return OrganizationCard(organization: organizations[pos]);
        },
        onIndexChanged: (index) {
          if (index >= organizations.length - 6) nextPage();
        },
      ),
    );
  }
}
