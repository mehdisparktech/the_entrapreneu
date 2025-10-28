class MyPostsModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<PostData>? data;

  MyPostsModel({
    this.success,
    this.message,
    this.pagination,
    this.data,
  });

  factory MyPostsModel.fromJson(Map<dynamic, dynamic> json) => MyPostsModel(
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null
        ? []
        : List<PostData>.from(
        json["data"]!.map((x) => PostData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Pagination {
  int? total;
  int? limit;
  int? page;
  int? totalPage;

  Pagination({
    this.total,
    this.limit,
    this.page,
    this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    limit: json["limit"],
    page: json["page"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "page": page,
    "totalPage": totalPage,
  };
}

class PostData {
  String? id;
  String? title;
  String? description;
  String? image;
  Category? category;
  double? lat;
  double? long;
  String? serviceDate;
  String? serviceTime;
  int? price;
  String? priority;
  String? bookingStatus;
  User? user;
  String? createdAt;
  String? updatedAt;

  PostData({
    this.id,
    this.title,
    this.description,
    this.image,
    this.category,
    this.lat,
    this.long,
    this.serviceDate,
    this.serviceTime,
    this.price,
    this.priority,
    this.bookingStatus,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    serviceDate: json["serviceDate"],
    serviceTime: json["serviceTime"],
    price: json["price"],
    priority: json["priority"],
    bookingStatus: json["bookingStatus"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "image": image,
    "category": category?.toJson(),
    "lat": lat,
    "long": long,
    "serviceDate": serviceDate,
    "serviceTime": serviceTime,
    "price": price,
    "priority": priority,
    "bookingStatus": bookingStatus,
    "user": user?.toJson(),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class Category {
  String? id;
  String? name;
  String? icon;
  int? commission;
  List<String>? subCategories;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.icon,
    this.commission,
    this.subCategories,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
    commission: json["commission"],
    subCategories: json["subCategories"] == null
        ? []
        : List<String>.from(json["subCategories"]!.map((x) => x)),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
    "commission": commission,
    "subCategories": subCategories == null
        ? []
        : List<dynamic>.from(subCategories!.map((x) => x)),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? image;
  List<dynamic>? skill;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.skill,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    skill: json["skill"] == null
        ? []
        : List<dynamic>.from(json["skill"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "image": image,
    "skill":
    skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
  };
}