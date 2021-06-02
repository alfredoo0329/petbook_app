import 'package:flutter/material.dart';
import 'package:petbook_app/src/models/general_models.dart';
import 'package:petbook_app/src/models/organization_model.dart';
import 'package:petbook_app/src/utils/utils.dart';

class OrganizationCard extends StatelessWidget {
  OrganizationCard({this.organization});

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(33),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(37, 20, 94, .26),
                blurRadius: 16,
                offset: Offset(3, 3),
                spreadRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: _getOrganizationImage(
                organization.uniqueIdImage, organization.photos),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Column(
              children: [
                _getOrganizationTime(context, organization.hours,
                    organization.distance, organization.uniqueIdTopTitle),
                _getOrganizationTitle(
                    organization.uniqueIdTitle, context, organization.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'SHARE',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'LIKE',
                        style: TextStyle(fontSize: 12, color: Colors.pink),
                      ),
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getOrganizationImage(String id, List<Photos> photos) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        child: Hero(
          tag: id,
          child: Image(
            fit: BoxFit.fitWidth,
            image: photos.isNotEmpty
                ? NetworkImage(photos[0].medium)
                : AssetImage('assets/images/NoShelter.jpg'),
            errorBuilder: (_, __, ___) =>
                Image(image: AssetImage('assets/images/NoShelter.jpg')),
          ),
        ),
      ),
    );
  }

  Widget _getOrganizationTime(
      BuildContext context, Hours time, double distance, String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getTimeString(time),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        distance != null
            ? Hero(
                tag: id,
                child: Text(
                  '${distance.ceil()}MI',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Widget _getOrganizationTitle(String id, BuildContext context, String name) {
    return Hero(
      tag: id,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Poppins'),
        child: Tooltip(
          message: name.trim(),
          child: RichText(
            maxLines: 3,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: name.trim(),
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColorDark),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      height: .6,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
