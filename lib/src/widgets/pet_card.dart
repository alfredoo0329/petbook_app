import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petbook_app/src/models/general_models.dart';
import 'package:petbook_app/src/models/pet_model.dart';
import 'package:petbook_app/src/utils/utils.dart';

class PetCard extends StatelessWidget {
  PetCard({this.pet});

  final Pet pet;

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
            child: _getPetImage(pet.uniqueIdImage, pet.photos, pet.type),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Column(
              children: [
                _getPetTopTitle(
                    pet.uniqueIdTopTitle, context, pet.status, pet.distance),
                _getPetTitle(pet.uniqueIdTitle, context, pet.name, pet.gender,
                    pet.tags.isNotEmpty),
                Hero(
                  tag: pet.uniqueIdTags,
                  child: DefaultTextStyle(
                      style: TextStyle(fontFamily: 'Poppins'),
                      child: _getPetTags(pet.tags)),
                ),
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

  Widget _getPetImage(String id, List<Photos> photos, String type) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        child: Hero(
          tag: id,
          child: Image(
            fit: BoxFit.cover,
            image: photos.isNotEmpty
                ? NetworkImage(photos[0].medium)
                : AssetImage(getImageByType(type)),
            errorBuilder: (_, __, ___) =>
                Image(image: AssetImage(getImageByType(type))),
          ),
        ),
      ),
    );
  }

  Widget _getPetTopTitle(
      String id, BuildContext context, String status, double distance) {
    return Hero(
      tag: id,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Poppins'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status.toUpperCase(),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark),
            ),
            distance != null
                ? Text(
                    '${distance.ceil()}MI',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _getPetTitle(String id, BuildContext context, String name,
      String gender, bool hasTags) {
    return Padding(
      padding: hasTags ? EdgeInsets.only(bottom: 16.0) : EdgeInsets.zero,
      child: Hero(
        tag: id,
        child: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Poppins'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Tooltip(
                  message: name,
                  child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: name,
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
                                    color: Theme.of(context).primaryColor))
                          ])),
                ),
              ),
              Tooltip(
                message: gender,
                child: Icon(
                  gender == 'Female'
                      ? MdiIcons.genderFemale
                      : MdiIcons.genderMale,
                  color: gender == 'Female' ? Colors.pink : Colors.blue,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPetTags(List<String> tags) {
    if (tags == null) return Container();
    if (tags.isEmpty) return Container();
    ListView tagList = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, pos) {
          return _getTag(
              tags[pos],
              (pos + 1) % 2 == 0
                  ? const Color.fromRGBO(255, 172, 139, 1)
                  : const Color.fromRGBO(255, 139, 139, 1));
        });
    return Container(height: 26, child: tagList);
  }

  Widget _getTag(String tag, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 14,
          color: color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Text(
            tag.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.2),
          ),
        ),
      ),
    );
  }
}
