class ChatMessageModel {
  final DateTime time;
  final String text;
  final String image; // Sender's profile image
  final String? messageImage; // Image sent in the message
  final bool isMe;
  final bool isNotice;
  final bool isUploading; // Flag for uploading state

  ChatMessageModel({
    required this.time,
    required this.text,
    required this.image,
    this.messageImage,
    this.isMe = false,
    this.isNotice = false,
    this.isUploading = false,
  });
}