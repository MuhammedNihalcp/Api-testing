class UserAllList {
  UserAllList({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
    this.message,
  });

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserList>? data;
  Support? support;
  String? message;

  factory UserAllList.fromJson(Map<String, dynamic> json) => UserAllList(
        page: json["page"] ?? '',
        perPage: json["per_page"] ?? '',
        total: json["total"] ?? '',
        totalPages: json["total_pages"] ?? '',
        data: json["data"] == null
            ? null
            : List<UserList>.from(
                json["data"].map((x) => UserList.fromJson(x))),
        support:
            json["support"] == null ? null : Support.fromJson(json["support"]),
        message: json["message"] ?? '',
      );
}

class UserList {
  UserList({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"] ?? '',
        email: json["email"] ?? '',
        firstName: json["first_name"] ?? '',
        lastName: json["last_name"] ?? '',
        avatar: json["avatar"] ?? '',
      );
}

class Support {
  Support({
    this.url,
    this.text,
  });

  String? url;
  String? text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"] ?? '',
        text: json["text"] ?? '',
      );
}
