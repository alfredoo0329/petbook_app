import 'package:flutter/material.dart';
import 'package:petbook_app/src/models/general_models.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments;
    final String tag = arguments['id'];
    final Photos imagesUrl = arguments['images'];
    final String title = arguments['title'];

    return Scaffold(
      appBar: _getAppBar(context, title),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          loadingBuilder: (context, _) =>
              _getLoadingWidget(context, tag, imagesUrl.medium),
          imageProvider: NetworkImage(imagesUrl.full),
        ),
      ),
    );
  }

  Widget _getAppBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  Widget _getLoadingWidget(BuildContext context, String tag, String image) {
    return Container(
      child: Stack(alignment: Alignment.center, children: [
        Hero(
          tag: tag,
          child: Image(image: NetworkImage(image)),
        ),
        CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ]),
    );
  }
}
