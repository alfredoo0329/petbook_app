getInfoFromDecodedData(Map<String, dynamic> decodedData) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(decodedData.toString())
      .forEach((match) => print(match.group(0)));
}

String getImageByType(String type) {
  switch (type) {
    case 'Dog':
      return 'assets/images/NoDog.jpg';
    case 'Cat':
      return 'assets/images/NoCat.jpg';
    case 'Rabbit':
      return 'assets/images/NoRabbit.jpg';
    case 'Small & Furry':
      return 'assets/images/NoSmall.jpg';
    case 'Horse':
      return 'assets/images/NoHorse.jpg';
    case 'Bird':
      return 'assets/images/NoBird.jpg';
    case 'Scales, Fins & Other':
      return 'assets/images/NoScales.jpg';
    case 'Barnyard':
      return 'assets/images/NoBarnyard.jpg';
    default:
      return 'assets/images/NoOther.jpg';
  }
}
