import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petbook_app/src/models/pet_model.dart';

class PetDetailsPage extends StatefulWidget {
  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Pet pet = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _getAppBar(pet),
            SliverPadding(
              padding: EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _getPetTopTitle(
                      pet.uniqueIdTopTitle, context, pet.status, pet.distance),
                  _getPetTitle(pet.uniqueIdTitle, context, pet.name, pet.gender,
                      pet.tags.isNotEmpty),
                  Hero(
                    tag: pet.uniqueIdTags,
                    child: DefaultTextStyle(
                      style: TextStyle(fontFamily: 'Poppins'),
                      child: _getPetTags(pet.tags),
                    ),
                  ),
                  _getDescription(context, pet.description),
                  _getCharacteristics(
                      pet.age, pet.size, pet.breeds, pet.colors),
                  _getAttributes(pet.attributes),
                  _getEnvironment(pet.environment),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAppBar(Pet pet) {
    return SliverAppBar(
      pinned: true,
      iconTheme: IconThemeData(color: Colors.white),
      expandedHeight: 400,
      onStretchTrigger: () {
        return;
      },
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'SHARE',
            style: TextStyle(fontSize: 12, color: Colors.white),
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
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
          style: TextButton.styleFrom(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.zero,
            minimumSize: Size(50, 30),
          ),
        ),
        SizedBox(width: 18),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _getImageSlider(pet.uniqueIdImage, pet.photos, pet.type),
      ),
    );
  }

  Widget _getImageSlider(String id, List<Photos> photos, String type) {
    if (photos.isEmpty) return Container();
    return Container(
      width: double.infinity,
      height: 400,
      child: Swiper(
        layout: SwiperLayout.DEFAULT,
        itemCount: photos.length,
        pagination: photos.length > 1
            ? SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    space: 12, size: 12, activeSize: 16),
                margin: EdgeInsets.all(16),
              )
            : null,
        itemBuilder: (context, pos) {
          if (pos == 0)
            return Hero(
              tag: id,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(photos[pos].medium),
              ),
            );

          return Image(
            fit: BoxFit.cover,
            image: NetworkImage(photos[pos].medium),
          );
        },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Tooltip(
                  message: name,
                  child: RichText(
                    maxLines: 2,
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
                      ],
                    ),
                  ),
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

  Widget _getDescription(BuildContext context, String description) {
    return description != null
        ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              description,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  height: 1.8),
            ),
          )
        : Container();
  }

  Widget _getSectionTitle(String title) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColorDark),
        children: [
          TextSpan(
              text: '.',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: .6,
                  color: Theme.of(context).primaryColor))
        ],
      ),
    );
  }

  Widget _getCharacteristics(
      String age, String size, Breeds breed, PetColors colors) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle('Characteristics'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _getAge(age),
                SizedBox(width: 16),
                _getSize(size),
              ],
            ),
          ),
          _getBreed(breed),
          _getColors(colors),
        ],
      ),
    );
  }

  Widget _getAge(String age) {
    return Row(
      children: [
        Text('Age  ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Text(age, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300))
      ],
    );
  }

  Widget _getSize(String size) {
    return Row(
      children: [
        Text('Size  ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Text(size, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300))
      ],
    );
  }

  Widget _getBreed(Breeds breeds) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breed  ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${breeds.primary}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                breeds.secondary != null
                    ? Text(
                        '& ${breeds.secondary}',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getColors(PetColors colors) {
    return colors != null
        ? Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Colors  ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${colors.primary}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                      colors.secondary != null
                          ? Text(
                              '${colors.secondary}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )
                          : Container(),
                      colors.tertiary != null
                          ? Text(
                              '${colors.tertiary}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _getAttributes(Attributes attributes) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle('Attributes'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getIconSelected(
                    Icons.cut_rounded,
                    'spayed\nneutered',
                    attributes.spayedNeutered == null
                        ? false
                        : attributes.spayedNeutered),
                _getIconSelected(MdiIcons.paw, 'declawed',
                    attributes.declawed == null ? false : attributes.declawed),
                _getIconSelected(
                    MdiIcons.dumbbell,
                    'house\ntrained',
                    attributes.houseTrained == null
                        ? false
                        : attributes.houseTrained),
                _getIconSelected(
                    MdiIcons.heartFlash,
                    'special\nneeds',
                    attributes.specialNeeds == null
                        ? false
                        : attributes.specialNeeds),
                _getIconSelected(
                    MdiIcons.needle,
                    'shots\ncurrent',
                    attributes.shotsCurrent == null
                        ? false
                        : attributes.shotsCurrent)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEnvironment(Environment environment) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle('Environment'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getIconSelected(MdiIcons.dog, 'good with\ndogs',
                    environment.dogs == null ? false : environment.dogs),
                _getIconSelected(MdiIcons.cat, 'good with\ncats',
                    environment.cats == null ? false : environment.cats),
                _getIconSelected(
                    Icons.child_care,
                    'good with\nchildren',
                    environment.children == null
                        ? false
                        : environment.children),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconSelected(IconData icon, String text, bool selected) {
    return Column(
      children: [
        Icon(icon,
            size: 32,
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorDark),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                height: 1.1,
                fontWeight: FontWeight.w500,
                color: selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColorDark),
          ),
        ),
      ],
    );
  }
}
