import 'package:petbook_app/src/models/pet_model.dart';
import 'general_models.dart';

class Pets {
  List<Pet> petList;
  PetsPagination pagination;

  Pets({this.petList, this.pagination});

  Pets.fromJson(Map<String, dynamic> json) {
    if (json['animals'] != null) {
      petList = [];
      json['animals'].forEach((pet) {
        petList.add(new Pet.fromJson(pet));
      });
    }
    pagination = json['pagination'] != null
        ? new PetsPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.petList != null) {
      data['animals'] = this.petList.map((pet) => pet.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }

  List<int> getIdList() {
    if (petList == null) return [];
    List<int> ids = [];
    petList.forEach((pet) {
      ids.add(pet.id);
    });
    return ids;
  }
}

class PetsPagination {
  int countPerPage;
  int totalCount;
  int currentPage;
  int totalPages;
  PetsPaginationLinks lLinks;

  PetsPagination(
      {this.countPerPage,
      this.totalCount,
      this.currentPage,
      this.totalPages,
      this.lLinks});

  PetsPagination.fromJson(Map<String, dynamic> json) {
    countPerPage = json['count_per_page'];
    totalCount = json['total_count'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    lLinks = json['_links'] != null
        ? new PetsPaginationLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_per_page'] = this.countPerPage;
    data['total_count'] = this.totalCount;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class PetsPaginationLinks {
  Href previous;
  Href next;

  PetsPaginationLinks({this.previous, this.next});

  PetsPaginationLinks.fromJson(Map<String, dynamic> json) {
    previous =
        json['previous'] != null ? new Href.fromJson(json['previous']) : null;
    next = json['next'] != null ? new Href.fromJson(json['next']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previous != null) {
      data['previous'] = this.previous.toJson();
    }
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    return data;
  }
}
