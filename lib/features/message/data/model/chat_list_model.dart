class ChatModel {
  final String id;
  final Participant participant;
  final bool status;
  final LatestMessage latestMessage;

  ChatModel({
    required this.id,
    required this.participant,
    required this.status,
    required this.latestMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    // Get first participant from participants array
    List participants = json['participants'] ?? [];
    Map<String, dynamic> participantData = 
        participants.isNotEmpty ? participants[0] : {};
    
    return ChatModel(
      id: json['_id'] ?? '',
      participant: Participant.fromJson(participantData),
      status: json['status'] ?? false,
      latestMessage: LatestMessage.fromJson(json['lastMessage'] ?? {}),
    );
  }
}

class Participant {
  final String id;
  final String fullName;
  final String image;
  final List<String> skill;

  Participant({
    required this.id,
    required this.fullName,
    required this.image,
    required this.skill,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] ?? '',
      fullName: json['name'] ?? '',
      image: json['image'] ?? '',
      skill: List<String>.from(json['skill'] ?? []),
    );
  }
}

class LatestMessage {
  final String id;
  final String sender;
  final DateTime createdAt;

  LatestMessage({
    required this.id,
    required this.sender,
    required this.createdAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) {
    return LatestMessage(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
