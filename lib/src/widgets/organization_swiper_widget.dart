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
          //Navigator.pushNamed(context, 'pet', arguments: organizations[pos]);
        },
        itemBuilder: (BuildContext context, int pos) {
          organizations[pos].uniqueIdImage = '${organizations[pos].id}-image';
          organizations[pos].uniqueIdTitle = '${organizations[pos].id}-title';
          return OrganizationCard(organization: organizations[pos]);
        },
        onIndexChanged: (index) {
          if (index >= organizations.length - 6) nextPage();
        },
      ),
    );
  }
}
