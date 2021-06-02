class PetFilterModel {
  String type;
  String breed;
  String size;
  String gender;
  String age;
  String color;
  String coat;
  String status;
  String name;
  String organization;
  bool goodWithChildren;
  bool goodWithDogs;
  bool goodWithCats;
  bool houseTrained;
  bool declawed;
  bool specialNeeds;
  String location;
  int distance;
  String recent;

  PetFilterModel(
      {this.type,
      this.breed,
      this.size,
      this.gender,
      this.age,
      this.color,
      this.coat,
      this.status,
      this.name,
      this.organization,
      this.goodWithChildren: false,
      this.goodWithDogs: false,
      this.goodWithCats: false,
      this.houseTrained: false,
      this.declawed: false,
      this.specialNeeds: false,
      this.location,
      this.distance,
      this.recent});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.type != null) data['type'] = this.type;
    if (this.breed != null) data['breed'] = this.breed;
    if (this.size != null) data['size'] = this.size;
    if (this.gender != null) data['gender'] = this.gender;
    if (this.age != null) data['age'] = this.age;
    if (this.color != null) data['color'] = this.color;
    if (this.coat != null) data['coat'] = this.coat;
    if (this.status != null) data['status'] = this.status;
    if (this.name != null) data['name'] = this.name;
    if (this.organization != null) data['organization'] = this.organization;
    if (this.goodWithChildren != false && this.goodWithChildren != null)
      data['good_with_children'] = this.goodWithChildren.toString();
    if (this.goodWithDogs != false && this.goodWithDogs != null)
      data['good_with_dogs'] = this.goodWithDogs.toString();
    if (this.goodWithCats != false && this.goodWithCats != null)
      data['good_with_cats'] = this.goodWithCats.toString();
    if (this.houseTrained != false && this.houseTrained != null)
      data['house_trained'] = this.houseTrained.toString();
    if (this.declawed != false && this.declawed != null)
      data['declawed'] = this.declawed.toString();
    if (this.specialNeeds != false && this.specialNeeds != null)
      data['special_needs'] = this.specialNeeds.toString();
    if (this.location != null) data['location'] = this.location;
    if (this.distance != null) data['distance'] = this.distance;
    if (this.recent != null) data['recent'] = this.recent;
    return data;
  }
}
