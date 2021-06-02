import 'general_models.dart';

class Organization {
  String uniqueIdImage;
  String uniqueIdTitle;
  String uniqueIdTopTitle;

  String id;
  String name;
  String email;
  String phone;
  ContactAddress address;
  Hours hours;
  String url;
  String website;
  String missionStatement;
  Adoption adoption;
  SocialMedia socialMedia;
  List<Photos> photos;
  double distance;
  OrganizationLinks lLinks;

  Organization(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.hours,
      this.url,
      this.website,
      this.missionStatement,
      this.adoption,
      this.socialMedia,
      this.photos,
      this.distance,
      this.lLinks});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'] != null
        ? new ContactAddress.fromJson(json['address'])
        : null;
    hours = json['hours'] != null ? new Hours.fromJson(json['hours']) : null;
    url = json['url'];
    website = json['website'];
    missionStatement = json['mission_statement'];
    adoption = json['adoption'] != null
        ? new Adoption.fromJson(json['adoption'])
        : null;
    socialMedia = json['social_media'] != null
        ? new SocialMedia.fromJson(json['social_media'])
        : null;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    distance = json['distance'];
    lLinks = json['_links'] != null
        ? new OrganizationLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.hours != null) {
      data['hours'] = this.hours.toJson();
    }
    data['url'] = this.url;
    data['website'] = this.website;
    data['mission_statement'] = this.missionStatement;
    if (this.adoption != null) {
      data['adoption'] = this.adoption.toJson();
    }
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Hours {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  Hours(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Hours.fromJson(Map<String, dynamic> json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    sunday = json['sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }
}

class Adoption {
  String policy;
  String url;

  Adoption({this.policy, this.url});

  Adoption.fromJson(Map<String, dynamic> json) {
    policy = json['policy'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['policy'] = this.policy;
    data['url'] = this.url;
    return data;
  }
}

class SocialMedia {
  String facebook;
  String twitter;
  String youtube;
  String instagram;
  String pinterest;

  SocialMedia(
      {this.facebook,
      this.twitter,
      this.youtube,
      this.instagram,
      this.pinterest});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    youtube = json['youtube'];
    instagram = json['instagram'];
    pinterest = json['pinterest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    data['pinterest'] = this.pinterest;
    return data;
  }
}

class OrganizationLinks {
  Self self;
  Self animals;

  OrganizationLinks({this.self, this.animals});

  OrganizationLinks.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    animals =
        json['animals'] != null ? new Self.fromJson(json['animals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.animals != null) {
      data['animals'] = this.animals.toJson();
    }
    return data;
  }
}
