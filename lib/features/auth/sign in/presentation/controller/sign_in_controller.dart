import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../services/storage/storage_services.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'developernaimul00@gmail.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : "",
  );

  /// Sign in Api call here

  Future<void> signInUser(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;
    Get.toNamed(AppRoutes.profile);
    return;

    isLoading = true;
    update();

    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = await ApiService.post(
      ApiEndPoint.signIn,
      body: body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.token = data['data']["accessToken"];
      LocalStorage.userId = data['data']["attributes"]["_id"];
      LocalStorage.myImage = data['data']["attributes"]["image"];
      LocalStorage.myName = data['data']["attributes"]["fullName"];

      LocalStorage.myEmail = data['data']["attributes"]["email"];
      LocalStorage.isLogIn = true;

      LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
      LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
      LocalStorage.setString(LocalStorageKeys.myImage, LocalStorage.myImage);
      LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
      LocalStorage.setString(LocalStorageKeys.myEmail, LocalStorage.myEmail);

      // if (LocalStorage.myRole == 'consultant') {
      //   Get.offAllNamed(AppRoutes.doctorHome);
      // } else {
      //   Get.offAllNamed(AppRoutes.patientsHome);
      // }

      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
