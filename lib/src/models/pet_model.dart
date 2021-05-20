import 'package:petbook_app/src/models/href_model.dart';

class Pet {
  int id;
  String organizationId;
  String url;
  String type;
  String species;
  Breeds breeds;
  PetColors colors;
  String age;
  String gender;
  String size;
  String coat;
  Attributes attributes;
  Environment environment;
  List<String> tags;
  String name;
  String description;
  List<Photos> photos;
  List<Videos> videos;
  String status;
  String publishedAt;
  Contact contact;
  Links lLinks;
  double distance;

  Pet(
      {this.id,
      this.organizationId,
      this.url,
      this.type,
      this.species,
      this.breeds,
      this.colors,
      this.age,
      this.gender,
      this.size,
      this.coat,
      this.attributes,
      this.environment,
      this.tags,
      this.name,
      this.description,
      this.photos,
      this.videos,
      this.status,
      this.publishedAt,
      this.contact,
      this.lLinks,
      this.distance});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    url = json['url'];
    type = json['type'];
    species = json['species'];
    breeds =
        json['breeds'] != null ? new Breeds.fromJson(json['breeds']) : null;
    colors =
        json['colors'] != null ? new PetColors.fromJson(json['colors']) : null;
    age = json['age'];
    gender = json['gender'];
    size = json['size'];
    coat = json['coat'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
    environment = json['environment'] != null
        ? new Environment.fromJson(json['environment'])
        : null;
    tags = json['tags'].cast<String>();
    name = json['name'];
    description = json['description'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((photo) {
        photos.add(new Photos.fromJson(photo));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((video) {
        videos.add(new Videos.fromJson(video));
      });
    }
    status = json['status'];
    publishedAt = json['published_at'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organization_id'] = this.organizationId;
    data['url'] = this.url;
    data['type'] = this.type;
    data['species'] = this.species;
    if (this.breeds != null) {
      data['breeds'] = this.breeds.toJson();
    }
    if (this.colors != null) {
      data['colors'] = this.colors.toJson();
    }
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['size'] = this.size;
    data['coat'] = this.coat;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    if (this.environment != null) {
      data['environment'] = this.environment.toJson();
    }
    data['tags'] = this.tags;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['published_at'] = this.publishedAt;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    data['distance'] = this.distance;
    return data;
  }
}

class Breeds {
  String primary;
  String secondary;
  bool mixed;
  bool unknown;

  Breeds({this.primary, this.secondary, this.mixed, this.unknown});

  Breeds.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'];
    mixed = json['mixed'];
    unknown = json['unknown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    data['mixed'] = this.mixed;
    data['unknown'] = this.unknown;
    return data;
  }
}

class PetColors {
  String primary;
  String secondary;
  String tertiary;

  PetColors({this.primary, this.secondary, this.tertiary});

  PetColors.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'];
    tertiary = json['tertiary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    data['tertiary'] = this.tertiary;
    return data;
  }
}

class Attributes {
  bool spayedNeutered;
  bool houseTrained;
  bool declawed;
  bool specialNeeds;
  bool shotsCurrent;

  Attributes(
      {this.spayedNeutered,
      this.houseTrained,
      this.declawed,
      this.specialNeeds,
      this.shotsCurrent});

  Attributes.fromJson(Map<String, dynamic> json) {
    spayedNeutered = json['spayed_neutered'];
    houseTrained = json['house_trained'];
    declawed = json['declawed'];
    specialNeeds = json['special_needs'];
    shotsCurrent = json['shots_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spayed_neutered'] = this.spayedNeutered;
    data['house_trained'] = this.houseTrained;
    data['declawed'] = this.declawed;
    data['special_needs'] = this.specialNeeds;
    data['shots_current'] = this.shotsCurrent;
    return data;
  }
}

class Environment {
  bool children;
  bool dogs;
  bool cats;

  Environment({this.children, this.dogs, this.cats});

  Environment.fromJson(Map<String, dynamic> json) {
    children = json['children'];
    dogs = json['dogs'];
    cats = json['cats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['children'] = this.children;
    data['dogs'] = this.dogs;
    data['cats'] = this.cats;
    return data;
  }
}

class Photos {
  String small;
  String medium;
  String large;
  String full;

  Photos({this.small, this.medium, this.large, this.full});

  Photos.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
    full = json['full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    data['full'] = this.full;
    return data;
  }
}

class Videos {
  String embed;

  Videos({this.embed});

  Videos.fromJson(Map<String, dynamic> json) {
    embed = json['embed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embed'] = this.embed;
    return data;
  }
}

class Contact {
  String email;
  String phone;
  Address address;

  Contact({this.email, this.phone, this.address});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;

  Address(
      {this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    return data;
  }
}

class Links {
  Href self;
  Href type;
  Href organization;

  Links({this.self, this.type, this.organization});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Href.fromJson(json['self']) : null;
    type = json['type'] != null ? new Href.fromJson(json['type']) : null;
    organization = json['organization'] != null
        ? new Href.fromJson(json['organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.organization != null) {
      data['organization'] = this.organization.toJson();
    }
    return data;
  }
}
