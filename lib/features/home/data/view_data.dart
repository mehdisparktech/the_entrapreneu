class ViewPostResponseModel {
  final bool success;
  final String message;
  final ViewData data;

  ViewPostResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ViewPostResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return ViewPostResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ViewData.fromJson(json['data'] ?? {}),
    );
  }
}

class ViewData {
  final String id;
  final String title;
  final String description;
  final String image;
  final String? category;
  final double lat;
  final double long;
  final String serviceDate;
  final String serviceTime;
  final int price;
  final String priority;
  final String bookingStatus;
  final PostUser user;
  final String createdAt;
  final String updatedAt;

  ViewData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.category,
    required this.lat,
    required this.long,
    required this.serviceDate,
    required this.serviceTime,
    required this.price,
    required this.priority,
    required this.bookingStatus,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ViewData.fromJson(Map<String, dynamic> json) {
    return ViewData(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] is String
          ? json['image']
          : (json['image']?['url'] ?? ''),
      category: json['category'] is String
          ? json['category']
          : (json['category']?['name'] ?? ''),
      lat: (json['lat'] ?? 0).toDouble(),
      long: (json['long'] ?? 0).toDouble(),
      serviceDate: json['serviceDate'] ?? '',
      serviceTime: json['serviceTime'] ?? '',
      price: json['price'] ?? 0,
      priority: json['priority'] ?? '',
      bookingStatus: json['bookingStatus'] ?? '',
      user: PostUser.fromJson(json['user'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

}

class PostUser {
  final String id;
  final String name;
  final String email;
  final String image;
  final List<String> skill;

  PostUser({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.skill,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
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