import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/features/profile/data/model/user_profile_model.dart';
import 'package:the_entrapreneu/services/storage/storage_keys.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';
import 'package:the_entrapreneu/utils/helpers/other_helper.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_utils.dart';

class ProfileController extends GetxController {
  /// Language List here
  List languages = ["English", "French", "Arabic"];

  /// form key here
  final formKey = GlobalKey<FormState>();

  /// select Language here
  String selectedLanguage = "English";

  /// select image here
  String? image;

  /// edit button loading here
  bool isLoading = false;

  UserProfileModel? profileModel;

  /// all controller here
  TextEditingController nameController = TextEditingController()
    ..text = LocalStorage.myName;
  TextEditingController numberController = TextEditingController()
    ..text = LocalStorage.mobile;
  TextEditingController passwordController = TextEditingController();
  TextEditingController aboutController = TextEditingController()
    ..text = LocalStorage.bio;
  TextEditingController dateOfBirthController = TextEditingController()
    ..text = LocalStorage.dateOfBirth.split('T').first;
  TextEditingController genderController = TextEditingController()
    ..text = LocalStorage.gender;
  TextEditingController addressController = TextEditingController();

  /// select image function here
  getProfileImage() async {
    image = await OtherHelper.openGalleryForProfile();
    update();
  }

  /// select language  function here
  selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// select date of birth function here
  Future<void> selectDateOfBirth() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dateOfBirthController.text =
          "${pickedDate.day.toString().padLeft(2, '0')} ${_getMonthName(pickedDate.month)} ${pickedDate.year}";
      update();
    }
  }

  /// Get month name
  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  /// select gender function here
  void selectGender(String gender) {
    genderController.text = gender;
    update();
  }

  /// select address function here
  Future<void> selectAddress() async {
    // This would typically open a location picker
    // For now, we'll just allow manual input
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "name": nameController.text,
      "phone": numberController.text,
      "bio": aboutController.text,
      "birthDate": dateOfBirthController.text,
      "gender": genderController.text,
      "lat": "23.8103",
      "log": "90.4125",
    };

    var response = await ApiService.patch(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.userId = data['data']?["_id"] ?? "";
      LocalStorage.myName = data['data']?["name"] ?? "";
      LocalStorage.myEmail = data['data']?["email"] ?? "";

      LocalStorage.setString("userId", LocalStorage.userId);
      LocalStorage.setString("myImage", LocalStorage.myImage);
      LocalStorage.setString("myName", LocalStorage.myName);
      LocalStorage.setString("myEmail", LocalStorage.myEmail);

      Utils.successSnackBar("Successfully Profile Updated", response.message);
      Get.toNamed(AppRoutes.profile);
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }

    isLoading = false;
    update();
  }

  /// delete account function here
  Future<void> deleteAccountRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {"password": passwordController.text};

    var response = await ApiService.post(ApiEndPoint.user, body: body);

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
      Utils.successSnackBar("Successfully Account Deleted", response.message);
      Get.back();
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }

    isLoading = false;
    update();
  }
}
