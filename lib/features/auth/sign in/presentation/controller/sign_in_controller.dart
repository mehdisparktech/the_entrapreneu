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
    //
    // return;

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
      LocalStorage.isLogIn = true;

      LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);

      getUserData();

      Get.toNamed(AppRoutes.homeNav);

      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  Future<void> getUserData() async {
    isLoading = true;
    update();

    var response = await ApiService.get(
      ApiEndPoint.profile,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.userId = data['data']?["_id"];
      LocalStorage.myImage = data['data']?["image"];
      LocalStorage.myName = data['data']?["name"];
      LocalStorage.myEmail = data['data']?["email"];
      LocalStorage.myRole = data['data']?["role"];

      LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
      LocalStorage.setString(LocalStorageKeys.myImage, LocalStorage.myImage);
      LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
      LocalStorage.setString(LocalStorageKeys.myEmail, LocalStorage.myEmail);
      LocalStorage.setString(LocalStorageKeys.myRole, LocalStorage.myRole);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
