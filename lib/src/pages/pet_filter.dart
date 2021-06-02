import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petbook_app/src/icon_models/pet_icons.dart';
import 'package:petbook_app/src/models/pet_filter_model.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:provider/provider.dart';

class PetFilter extends StatefulWidget {
  @override
  _PetFilterState createState() => _PetFilterState();
}

class _PetFilterState extends State<PetFilter> {
  PetFilterModel _petFilter;
  List<DropdownMenuItem> _breedList = [];
  List<DropdownMenuItem> _colorList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _setBreedColorDrops(_petFilter.type));
  }

  @override
  Widget build(BuildContext context) {
    _petFilter =
        Provider.of<PetfinderProvider>(context, listen: false).petFilter;

    return Scaffold(
      appBar: _getAppBar(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _getAnimalType(context),
                  _getCharacteristics(context),
                  _getAttributes(context),
                  _getEnvironment(context),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getAppBar(BuildContext context) {
    return AppBar(
      title: Text('Filter By', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: _applyFilter),
        IconButton(
            icon: Icon(Icons.restore_page_rounded),
            onPressed: () {
              setState(() {
                _petFilter.type = null;
                _petFilter.age = null;
                _petFilter.status = null;
                _petFilter.gender = null;
                _petFilter.size = null;
                _petFilter.breed = null;
                _petFilter.color = null;
                _breedList = [];
                _colorList = [];
                _petFilter.houseTrained = false;
                _petFilter.declawed = false;
                _petFilter.specialNeeds = false;
                _petFilter.goodWithCats = false;
                _petFilter.goodWithChildren = false;
                _petFilter.goodWithDogs = false;
              });
            }),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  Widget _getAnimalType(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(context, 'Animal Type'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getIconSelected(
                  context,
                  _petFilter.type == 'Rabbit',
                  PetIcons.bunny,
                  'rabbit',
                  () => _setBreedColorDrops('Rabbit'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Scales, Fins & Other',
                  PetIcons.scale,
                  'scale',
                  () => _setBreedColorDrops('Scales, Fins & Other'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Dog',
                  FontAwesomeIcons.dog,
                  'dog',
                  () => _setBreedColorDrops('Dog'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Cat',
                  FontAwesomeIcons.cat,
                  'cat',
                  () => _setBreedColorDrops('Cat'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getIconSelected(
                  context,
                  _petFilter.type == 'Barnyard',
                  PetIcons.pig,
                  'barnyard',
                  () => _setBreedColorDrops('Barnyard'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Small & Furry',
                  PetIcons.furry,
                  'small\n& furry',
                  () => _setBreedColorDrops('Small & Furry'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Horse',
                  FontAwesomeIcons.horse,
                  'horse',
                  () => _setBreedColorDrops('Horse'),
                ),
                _getIconSelected(
                  context,
                  _petFilter.type == 'Bird',
                  PetIcons.bird,
                  'bird',
                  () => _setBreedColorDrops('Bird'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setBreedColorDrops(String type) {
    if (type == null) return;
    if (type != _petFilter.type) {
      _petFilter.breed = null;
      _petFilter.color = null;
    }
    PetfinderProvider petfinder =
        Provider.of<PetfinderProvider>(context, listen: false);
    setState(() {
      _petFilter.type = type;
      _breedList = [];
    });
    petfinder.getPetBreeds(type).then((breeds) => _getBreeds(breeds));
    petfinder.getPetColors(type).then((colors) => _getColors(colors));
  }

  Widget _getCharacteristics(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        _getSectionTitle(context, 'Characteristics'),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getGenderDrop(),
            _getStatusDrop(),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getAgeDrop(),
            _getSizeDrop(),
          ],
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: Text('To choose Breed and Color select One Animal Type',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  height: 1.8)),
        ),
        SizedBox(height: 16),
        _getBreedDrop(),
        SizedBox(height: 16),
        _getColorDrop(),
      ],
    );
  }

  Widget _getGenderDrop() {
    return DropdownButton(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColorDark),
      hint: Text('Gender'),
      elevation: 0,
      value: _petFilter.gender,
      icon: Icon(Icons.arrow_drop_down),
      items: [
        _getDropdownItem(title: 'Any'),
        _getDropdownItem(
            title: 'Male',
            value: 'male',
            icon: MdiIcons.genderMale,
            color: Colors.blue),
        _getDropdownItem(
            title: 'Female',
            value: 'female',
            icon: MdiIcons.genderFemale,
            color: Colors.pink),
        _getDropdownItem(
            title: 'Unknown',
            value: 'unknown',
            icon: FontAwesomeIcons.genderless),
      ],
      onChanged: (value) {
        setState(() {
          _petFilter.gender = value;
        });
      },
    );
  }

  Widget _getStatusDrop() {
    return DropdownButton(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColorDark),
      hint: Text('Status'),
      elevation: 0,
      value: _petFilter.status,
      icon: Icon(Icons.arrow_drop_down),
      items: [
        _getDropdownItem(title: 'Any'),
        _getDropdownItem(title: 'Adopted', value: 'adopted'),
        _getDropdownItem(title: 'Adoptable', value: 'adoptable'),
      ],
      onChanged: (value) {
        setState(() {
          _petFilter.status = value;
        });
      },
    );
  }

  Widget _getAgeDrop() {
    return DropdownButton(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColorDark),
      hint: Text('Age'),
      elevation: 0,
      value: _petFilter.age,
      icon: Icon(Icons.arrow_drop_down),
      items: [
        _getDropdownItem(title: 'Any'),
        _getDropdownItem(title: 'Baby', value: 'baby'),
        _getDropdownItem(title: 'Young', value: 'young'),
        _getDropdownItem(title: 'Adult', value: 'adult'),
        _getDropdownItem(title: 'Senior', value: 'senior'),
      ],
      onChanged: (value) {
        setState(() {
          _petFilter.age = value;
        });
      },
    );
  }

  Widget _getSizeDrop() {
    return DropdownButton(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColorDark),
      hint: Text('Size'),
      elevation: 0,
      value: _petFilter.size,
      icon: Icon(Icons.arrow_drop_down),
      items: [
        _getDropdownItem(title: 'Any'),
        _getDropdownItem(title: 'Small', value: 'small'),
        _getDropdownItem(title: 'Medium', value: 'medium'),
        _getDropdownItem(title: 'Large', value: 'large'),
        _getDropdownItem(title: 'Extra Large', value: 'xlarge'),
      ],
      onChanged: (value) {
        setState(() {
          _petFilter.size = value;
        });
      },
    );
  }

  Widget _getBreedDrop() {
    return Container(
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColorDark),
        hint: Text('Breed'),
        elevation: 0,
        value: _petFilter.breed,
        icon: Icon(Icons.arrow_drop_down),
        items: _breedList,
        onChanged: (value) {
          setState(() {
            _petFilter.breed = value;
          });
        },
      ),
    );
  }

  void _getBreeds(List<String> breeds) {
    _breedList = [_getDropdownItem(title: 'Any')];
    setState(() {
      breeds.forEach((breed) {
        _breedList.add(_getDropdownItem(title: breed, value: breed));
      });
    });
  }

  Widget _getColorDrop() {
    return Container(
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColorDark),
        hint: Text('Color'),
        elevation: 0,
        value: _petFilter.color,
        icon: Icon(Icons.arrow_drop_down),
        items: _colorList,
        onChanged: (value) {
          setState(() {
            _petFilter.color = value;
          });
        },
      ),
    );
  }

  void _getColors(List<String> colors) {
    _colorList = [_getDropdownItem(title: 'Any')];
    setState(() {
      colors.forEach((color) {
        _colorList.add(_getDropdownItem(title: color, value: color));
      });
    });
  }

  DropdownMenuItem<String> _getDropdownItem(
      {String title, String value, IconData icon, Color color}) {
    return DropdownMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          SizedBox(width: 12),
          icon == null
              ? Container()
              : Icon(icon,
                  color: color == null
                      ? Theme.of(context).primaryColorDark
                      : color),
        ],
      ),
      value: value,
    );
  }

  Widget _getAttributes(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(context, 'Attributes'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getIconSelected(
                  context,
                  _petFilter.declawed,
                  MdiIcons.paw,
                  'declawed',
                  () {
                    setState(() {
                      _petFilter.declawed = !_petFilter.declawed;
                    });
                  },
                ),
                _getIconSelected(
                  context,
                  _petFilter.houseTrained,
                  MdiIcons.dogService,
                  'house\ntrained',
                  () {
                    setState(() {
                      _petFilter.houseTrained = !_petFilter.houseTrained;
                    });
                  },
                ),
                _getIconSelected(
                  context,
                  _petFilter.specialNeeds,
                  MdiIcons.heartFlash,
                  'special\nneeds',
                  () {
                    setState(() {
                      _petFilter.specialNeeds = !_petFilter.specialNeeds;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getEnvironment(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(context, 'Environment'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getIconSelected(
                  context,
                  _petFilter.goodWithDogs,
                  MdiIcons.dog,
                  'good with\ndogs',
                  () {
                    setState(() {
                      _petFilter.goodWithDogs = !_petFilter.goodWithDogs;
                    });
                  },
                ),
                _getIconSelected(
                  context,
                  _petFilter.goodWithCats,
                  MdiIcons.cat,
                  'good with\ncats',
                  () {
                    setState(() {
                      _petFilter.goodWithCats = !_petFilter.goodWithCats;
                    });
                  },
                ),
                _getIconSelected(
                  context,
                  _petFilter.goodWithChildren,
                  Icons.child_care,
                  'good with\nchildren',
                  () {
                    setState(() {
                      _petFilter.goodWithChildren =
                          !_petFilter.goodWithChildren;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconSelected(BuildContext context, bool selected, IconData icon,
      String text, void Function() action) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon,
              size: 34,
              color: selected
                  ? Theme.of(context).primaryColor
                  : Color.fromRGBO(255, 143, 101, .5)),
          onPressed: action,
        ),
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
                    : Color.fromRGBO(255, 143, 101, .5)),
          ),
        ),
      ],
    );
  }

  Widget _getSectionTitle(BuildContext context, String title) {
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

  void _applyFilter() {
    Provider.of<PetfinderProvider>(context, listen: false)
        .applyNewFilter(_petFilter);
    Navigator.pop(context);
  }
}
