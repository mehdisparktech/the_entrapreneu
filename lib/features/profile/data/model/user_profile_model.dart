class UserProfileModel {
  final bool? success;
  final String? message;
  final UserProfileData? data;

  UserProfileModel({
    this.success,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UserProfileData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UserProfileData {
  final AccountInformation? accountInformation;
  final double? balance;
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final String? image;
  final bool? verified;
  final String? birthDate;
  final String? gender;
  final List<String>? skill;
  final double? lat;
  final double? log;
  final String? experience;
  final String? bio;
  final bool? isDelete;
  final bool? isBan;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  UserProfileData({
    this.accountInformation,
    this.balance,
    this.id,
    this.name,
    this.role,
    this.email,
    this.image,
    this.verified,
    this.birthDate,
    this.gender,
    this.skill,
    this.lat,
    this.log,
    this.experience,
    this.bio,
    this.isDelete,
    this.isBan,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      accountInformation: json['accountInformation'] != null
          ? AccountInformation.fromJson(
              json['accountInformation'] as Map<String, dynamic>)
          : null,
      balance: json['balance'] != null
          ? (json['balance'] is int
              ? (json['balance'] as int).toDouble()
              : json['balance'] as double?)
          : null,
      id: json['_id'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      verified: json['verified'] as bool?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
      skill: json['skill'] != null
          ? List<String>.from(json['skill'] as List)
          : null,
      lat: json['lat'] != null
          ? (json['lat'] is int
              ? (json['lat'] as int).toDouble()
              : json['lat'] as double?)
          : null,
      log: json['log'] != null
          ? (json['log'] is int
              ? (json['log'] as int).toDouble()
              : json['log'] as double?)
          : null,
      experience: json['experience'] as String?,
      bio: json['bio'] as String?,
      isDelete: json['isDelete'] as bool?,
      isBan: json['isBan'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountInformation': accountInformation?.toJson(),
      'balance': balance,
      '_id': id,
      'name': name,
      'role': role,
      'email': email,
      'image': image,
      'verified': verified,
      'birthDate': birthDate,
      'gender': gender,
      'skill': skill,
      'lat': lat,
      'log': log,
      'experience': experience,
      'bio': bio,
      'isDelete': isDelete,
      'isBan': isBan,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class AccountInformation {
  final bool? status;

  AccountInformation({
    this.status,
  });

  factory AccountInformation.fromJson(Map<String, dynamic> json) {
    return AccountInformation(
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
