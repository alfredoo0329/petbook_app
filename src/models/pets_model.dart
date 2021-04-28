import 'package:petbook_flutter/src/models/pet_model.dart';
import 'href_model.dart';

class Pets {
  List<Pet> pets;
  Pagination pagination;

  Pets({this.pets, this.pagination});

  Pets.fromJson(Map<String, dynamic> json) {
    if (json['animals'] != null) {
      pets = [];
      json['animals'].forEach((pet) {
        pets.add(new Pet.fromJson(pet));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pets != null) {
      data['animals'] = this.pets.map((pet) => pet.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Pagination {
  int countPerPage;
  int totalCount;
  int currentPage;
  int totalPages;
  Links lLinks;

  Pagination(
      {this.countPerPage,
      this.totalCount,
      this.currentPage,
      this.totalPages,
      this.lLinks});

  Pagination.fromJson(Map<String, dynamic> json) {
    countPerPage = json['count_per_page'];
    totalCount = json['total_count'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
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

class Links {
  Href previous;
  Href next;

  Links({this.previous, this.next});

  Links.fromJson(Map<String, dynamic> json) {
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
