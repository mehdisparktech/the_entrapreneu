import 'package:get/get.dart';
import 'package:the_entrapreneu/config/api/api_end_point.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/features/profile/data/model/user_profile_model.dart';
import 'package:the_entrapreneu/services/api/api_service.dart';
import 'package:the_entrapreneu/services/storage/storage_keys.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';

class MyProfileController extends GetxController {
  bool isLoading = false;
  UserProfileModel? profileModel;

  /// User profile data
  String get userName =>
      LocalStorage.myName.isNotEmpty ? LocalStorage.myName : "Shakir Ahmed";

  String get userImage => LocalStorage.myImage;

  String get userEmail => LocalStorage.myEmail.isNotEmpty
      ? LocalStorage.myEmail
      : "Example@gmail.com";

  String get mobile => LocalStorage.mobile;
  String get dateOfBirth {
    if (LocalStorage.dateOfBirth.isEmpty) return "";
    // Extract only the date part (YYYY-MM-DD) from ISO timestamp
    return LocalStorage.dateOfBirth.split('T').first;
  }

  String get gender => LocalStorage.gender;
  String get experience => LocalStorage.experience;
  String get bio => LocalStorage.bio;
  double get balance => LocalStorage.balance;
  bool get verified => LocalStorage.verified;
  double get lat => LocalStorage.lat;
  double get log => LocalStorage.log;
  bool get accountInfoStatus => LocalStorage.accountInfoStatus;
  String get address => "Dhaka, Bangladesh";
  String get about => LocalStorage.bio.isNotEmpty
      ? LocalStorage.bio
      : "Skilled professionals offering reliable, on-demand services to meet your everyday needs quickly and efficiently.";

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  /// Navigate to edit profile screen
  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  Future<void> getUserData() async {
    isLoading = true;
    update();

    try {
      var response = await ApiService.get(
        ApiEndPoint.profile,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Parse response to model
        profileModel = UserProfileModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        if (profileModel?.data != null) {
          final data = profileModel!.data!;

          // Update LocalStorage variables
          LocalStorage.userId = data.id ?? "";
          LocalStorage.myImage = data.image ?? "";
          LocalStorage.myName = data.name ?? "";
          LocalStorage.myEmail = data.email ?? "";
          LocalStorage.myRole = data.role ?? "";
          LocalStorage.dateOfBirth = data.birthDate ?? "";
          LocalStorage.gender = data.gender ?? "";
          LocalStorage.experience = data.experience ?? "";
          LocalStorage.balance = data.balance ?? 0.0;
          LocalStorage.verified = data.verified ?? false;
          LocalStorage.bio = data.bio ?? "";
          LocalStorage.lat = data.lat ?? 0.0;
          LocalStorage.log = data.log ?? 0.0;
          LocalStorage.accountInfoStatus =
              data.accountInformation?.status ?? false;
          LocalStorage.createdAt = data.createdAt ?? "";
          LocalStorage.updatedAt = data.updatedAt ?? "";

          // Save to SharedPreferences
          await LocalStorage.setBool(
            LocalStorageKeys.isLogIn,
            LocalStorage.isLogIn,
          );
          await LocalStorage.setString(
            LocalStorageKeys.userId,
            LocalStorage.userId,
          );
          await LocalStorage.setString(
            LocalStorageKeys.myImage,
            LocalStorage.myImage,
          );
          await LocalStorage.setString(
            LocalStorageKeys.myName,
            LocalStorage.myName,
          );
          await LocalStorage.setString(
            LocalStorageKeys.myEmail,
            LocalStorage.myEmail,
          );
          await LocalStorage.setString(
            LocalStorageKeys.myRole,
            LocalStorage.myRole,
          );
          await LocalStorage.setString(
            LocalStorageKeys.dateOfBirth,
            LocalStorage.dateOfBirth,
          );
          await LocalStorage.setString(
            LocalStorageKeys.gender,
            LocalStorage.gender,
          );
          await LocalStorage.setString(
            LocalStorageKeys.experience,
            LocalStorage.experience,
          );
          await LocalStorage.setDouble(
            LocalStorageKeys.balance,
            LocalStorage.balance,
          );
          await LocalStorage.setBool(
            LocalStorageKeys.verified,
            LocalStorage.verified,
          );
          await LocalStorage.setString(LocalStorageKeys.bio, LocalStorage.bio);
          await LocalStorage.setDouble(LocalStorageKeys.lat, LocalStorage.lat);
          await LocalStorage.setDouble(LocalStorageKeys.log, LocalStorage.log);
          await LocalStorage.setBool(
            LocalStorageKeys.accountInfoStatus,
            LocalStorage.accountInfoStatus,
          );
          await LocalStorage.setString(
            LocalStorageKeys.createdAt,
            LocalStorage.createdAt,
          );
          await LocalStorage.setString(
            LocalStorageKeys.updatedAt,
            LocalStorage.updatedAt,
          );
        }
      } else {
        Get.snackbar(response.statusCode.toString(), response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    }

    isLoading = false;
    update();
  }

  /// Navigate back
  void goBack() {
    Get.back();
  }
}
