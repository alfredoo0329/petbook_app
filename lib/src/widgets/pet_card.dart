import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  PetCard(
      {this.name, this.age, this.breed, this.size, this.gender, this.imageUrl});

  final String name;
  final String age;
  final String breed;
  final String size;
  final String gender;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 8,
          margin: EdgeInsets.fromLTRB(44, 18, 44, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                ),
                SizedBox(width: 16),
                Text(gender)
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Image(
            fit: BoxFit.cover,
            height: 250,
            width: MediaQuery.of(context).size.width - 44,
            image: NetworkImage(imageUrl.isNotEmpty
                ? imageUrl
                : 'https://icon-library.com/images/no-image-icon/no-image-icon-12.jpg'),
          ),
        ),
        Card(
          elevation: 8,
          margin: EdgeInsets.fromLTRB(44, 0, 44, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Size',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          ),
                          Text(size,
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          ),
                          Text(age,
                              style: TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Breed',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            breed,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_rounded),
                        label: Text('View more'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              return Colors.deepOrange[400];
                            },
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.share_rounded), onPressed: () {}),
                      IconButton(
                        icon: Icon(Icons.save_rounded),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}