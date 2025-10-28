class PostModel {
  final String id;
  final String userName;
  final String userImage;
  final String postTime;
  final String title;
  final String location;
  final String price;
  final String category;
  final String subCategory;
  final String date;
  final String time;
  final String description;
  final List<String> responsibilities;
  final List<String> requirements;
  final String imageUrl;

  PostModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.postTime,
    required this.title,
    required this.location,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.date,
    required this.time,
    required this.description,
    required this.responsibilities,
    required this.requirements,
    required this.imageUrl,
  });
}