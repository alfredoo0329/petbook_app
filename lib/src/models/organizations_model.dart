import 'general_models.dart';
import 'organization_model.dart';

class Organizations {
  List<Organization> organizationList;
  OrganizationsPagination pagination;

  Organizations({this.organizationList, this.pagination});

  Organizations.fromJson(Map<String, dynamic> json) {
    if (json['organizations'] != null) {
      organizationList = [];
      json['organizations'].forEach((v) {
        organizationList.add(new Organization.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new OrganizationsPagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.organizationList != null) {
      data['organizations'] =
          this.organizationList.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class OrganizationsPagination {
  int countPerPage;
  int totalCount;
  int currentPage;
  int totalPages;
  OrganizationsPaginationLinks lLinks;

  OrganizationsPagination(
      {this.countPerPage,
      this.totalCount,
      this.currentPage,
      this.totalPages,
      this.lLinks});

  OrganizationsPagination.fromJson(Map<String, dynamic> json) {
    countPerPage = json['count_per_page'];
    totalCount = json['total_count'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    lLinks = json['_links'] != null
        ? new OrganizationsPaginationLinks.fromJson(json['_links'])
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

class OrganizationsPaginationLinks {
  Self next;

  OrganizationsPaginationLinks({this.next});

  OrganizationsPaginationLinks.fromJson(Map<String, dynamic> json) {
    next = json['next'] != null ? new Self.fromJson(json['next']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    return data;
  }
}
