class NotificationModel {
  final String id;
  final String message;
  final String linkId;
  final String type;
  final String role;
  final String receiver;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.message,
    required this.linkId,
    required this.type,
    required this.role,
    required this.receiver,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? "",
      message: json['message'] ?? '',
      linkId: json['linkId'] ?? '',
      type: json['type'] ?? '',
      role: json['role'] ?? '',
      receiver: json['receiver'] ?? '',
      v: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }
}
