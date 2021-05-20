class PetTypes {
  List<PetType> types;

  PetTypes({this.types});

  PetTypes.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = [];
      json['types'].forEach((v) {
        types.add(new PetType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PetType {
  String name;
  List<String> coats;
  List<String> colors;
  List<String> genders;
  Links lLinks;

  PetType({this.name, this.coats, this.colors, this.genders, this.lLinks});

  PetType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coats = json['coats'].cast<String>();
    colors = json['colors'].cast<String>();
    genders = json['genders'].cast<String>();
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['coats'] = this.coats;
    data['colors'] = this.colors;
    data['genders'] = this.genders;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Links {
  Self self;
  Self breeds;

  Links({this.self, this.breeds});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    breeds = json['breeds'] != null ? new Self.fromJson(json['breeds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.breeds != null) {
      data['breeds'] = this.breeds.toJson();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
