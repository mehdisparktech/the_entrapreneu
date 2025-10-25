import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/app_utils.dart';

class SettingController extends GetxController {
  /// Password controller here , use for delete account
  TextEditingController passwordController = TextEditingController();

  /// loading check , use delete account
  bool isLoading = false;

  /// account delete api call here
  deleteAccountRepo() async {
    isLoading = true;
    update();

    var body = {"password": passwordController.text};

    var response = await ApiService.delete(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.signIn);
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
    }
    isLoading = false;
    update();
  }
}
