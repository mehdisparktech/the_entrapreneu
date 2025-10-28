class PostResponseModel {
  final bool success;
  final String message;
  final Pagination pagination;
  final List<Post> data;

  PostResponseModel({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory PostResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return PostResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class Pagination {
  final int total;
  final int limit;
  final int page;
  final int totalPage;

  Pagination({
    required this.total,
    required this.limit,
    required this.page,
    required this.totalPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      limit: json['limit'] ?? 10,
      page: json['page'] ?? 1,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class Post {
  final String id;
  final String title;
  final String description;
  final String image;
  final double lat;
  final double long;
  final String serviceDate;
  final String serviceTime;
  final int price;
  final String priority;
  final String bookingStatus;
  final User user;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.lat,
    required this.long,
    required this.serviceDate,
    required this.serviceTime,
    required this.price,
    required this.priority,
    required this.bookingStatus,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      long: (json['long'] ?? 0).toDouble(),
      serviceDate: json['serviceDate'] ?? '',
      serviceTime: json['serviceTime'] ?? '',
      price: json['price'] ?? 0,
      priority: json['priority'] ?? '',
      bookingStatus: json['bookingStatus'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String image;
  final List<String> skill;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.skill,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      skill: (json['skill'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ??
          [],
    );
  }
}