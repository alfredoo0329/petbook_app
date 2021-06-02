import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petbook_app/src/models/general_models.dart';
import 'package:petbook_app/src/models/organization_model.dart';
import 'package:petbook_app/src/widgets/mini_map_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Organization organization = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _getAppBar(context, organization),
            SliverPadding(
              padding: EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _getOrganizationTopTitle(organization.uniqueIdTopTitle,
                      context, organization.distance),
                  _getOrganizationTitle(
                      organization.uniqueIdTitle, context, organization.name),
                  _getOrganizationTime(context, organization.hours),
                  _getSection(
                      context, 'Mission', organization.missionStatement),
                  _getSection(
                      context, 'Adoption Policy', organization.adoption.policy),
                  _getLink(context, organization.adoption.url),
                  _getContactInformation(
                      context, organization.address, organization),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAppBar(BuildContext context, Organization organization) {
    return SliverAppBar(
      pinned: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      expandedHeight: organization.photos.isEmpty ? null : 400,
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
      flexibleSpace: organization.photos.isEmpty
          ? Container()
          : FlexibleSpaceBar(
              background: _getImageSlider(context, organization.uniqueIdImage,
                  organization.photos, organization.name),
            ),
    );
  }

  Widget _getImageSlider(
      BuildContext context, String id, List<Photos> photos, String name) {
    if (photos.isEmpty) return Container();

    if (photos.length == 1) {
      return Hero(
        tag: id,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'image',
                arguments: {'id': '$id-0', 'images': photos[0], 'title': name});
          },
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(photos[0].medium),
          ),
        ),
      );
    }

    return Swiper(
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

        return Hero(
          tag: '$id-$pos',
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(photos[pos].medium),
          ),
        );
      },
      onTap: (i) {
        Navigator.pushNamed(context, 'image',
            arguments: {'id': '$id-$i', 'images': photos[i], 'title': name});
      },
    );
  }

  Widget _getOrganizationTopTitle(
      String id, BuildContext context, double distance) {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: 'Poppins'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
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
              : SizedBox()
        ],
      ),
    );
  }

  Widget _getOrganizationTime(BuildContext context, Hours hours) {
    if (hours.monday == null &&
        hours.tuesday == null &&
        hours.thursday == null &&
        hours.wednesday == null &&
        hours.friday == null &&
        hours.saturday == null &&
        hours.sunday == null)
      return Text(
        'Time Not Available',
        overflow: TextOverflow.visible,
        style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.w300,
            fontSize: 16,
            height: 1.8),
      );
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _getHour(context, 'MONDAY', hours.monday),
          SizedBox(width: 16),
          _getHour(context, 'TUESDAY', hours.tuesday),
          SizedBox(width: 16),
          _getHour(context, 'WEDNSEDAY', hours.wednesday),
          SizedBox(width: 16),
          _getHour(context, 'THURSDAY', hours.thursday),
          SizedBox(width: 16),
          _getHour(context, 'FRIDAY', hours.friday),
          SizedBox(width: 16),
          _getHour(context, 'SATURDAY', hours.saturday),
          SizedBox(width: 16),
          _getHour(context, 'SUNDAY', hours.sunday)
        ],
      ),
    );
  }

  Widget _getHour(BuildContext context, String day, String time) {
    return Container(
      padding: EdgeInsets.only(bottom: 3),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Text(
              day,
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Text(time != null ? time : 'Closed',
                maxLines: 2,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w300,
                    fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _getOrganizationTitle(String id, BuildContext context, String name) {
    return Hero(
      tag: id,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: 'Poppins'),
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
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSection(BuildContext context, String title, String description) {
    if (description == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(context, '$title'),
          Padding(
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
        ],
      ),
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

  Widget _getLink(BuildContext context, String link) {
    if (link == null) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.link, color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                launch(link);
              },
              child: Text(link,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContactInformation(
      BuildContext context, ContactAddress contact, Organization organization) {
    String address = contact.address1 != null ? '${contact.address1}, ' : '';
    address += contact.city != null ? '${contact.city} ' : '';
    address += contact.postcode != null ? '${contact.postcode}, ' : '';
    address += contact.country != null ? '${contact.country} ' : '';

    return Container(
      padding: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSectionTitle(context, 'Contact Information'),
          organization.website != null
              ? _getLink(context, organization.website)
              : Container(),
          organization.email != null
              ? _getEmail(context, organization.email)
              : Container(),
          organization.phone != null
              ? _getPhones(context, organization.phone)
              : Container(),
          organization.address != null
              ? _getAddress(context, address)
              : Container(),
          MiniMap(address: address, title: organization.name),
          _getSocialMedia(context, organization.socialMedia),
        ],
      ),
    );
  }

  Widget _getEmail(BuildContext context, String email) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.email_rounded,
                color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(email,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          ),
        ],
      ),
    );
  }

  Widget _getPhones(BuildContext context, String phones) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.phone, color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(phones,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          ),
        ],
      ),
    );
  }

  Widget _getAddress(BuildContext context, String address) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child:
                Icon(MdiIcons.home, color: Theme.of(context).primaryColorDark),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(address,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          ),
        ],
      ),
    );
  }

  Widget _getSocialMedia(BuildContext context, SocialMedia socialMedia) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              disabledColor: Colors.blue[100],
              color: Colors.blue[800],
              icon: Icon(FontAwesomeIcons.facebook),
              onPressed: socialMedia.facebook == null
                  ? null
                  : () => launch(socialMedia.facebook)),
          IconButton(
              disabledColor: Colors.blue[100],
              color: Colors.blue[200],
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: socialMedia.twitter == null
                  ? null
                  : () => launch(socialMedia.twitter)),
          IconButton(
              disabledColor: Colors.red[100],
              color: Colors.red,
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.youtube),
              onPressed: socialMedia.youtube == null
                  ? null
                  : () => launch(socialMedia.youtube)),
          IconButton(
              disabledColor: Colors.purple[100],
              color: Colors.purple,
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.instagramSquare),
              onPressed: socialMedia.instagram == null
                  ? null
                  : () => launch(socialMedia.instagram)),
          IconButton(
              disabledColor: Colors.red[100],
              color: Colors.red,
              padding: EdgeInsets.zero,
              icon: Icon(FontAwesomeIcons.pinterest),
              onPressed: socialMedia.pinterest == null
                  ? null
                  : () => launch(socialMedia.pinterest))
        ],
      ),
    );
  }
}
