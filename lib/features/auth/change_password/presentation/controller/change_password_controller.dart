import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../services/api/api_service.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../utils/app_utils.dart';

class ChangePasswordController extends GetxController {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ///  change password function

  Future<void> changePasswordRepo() async {
    if (!formKey.currentState!.validate()) return;
    Get.back();
    return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "oldPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text,
    };
    var response = await ApiService.patch(
      ApiEndPoint.changePassword,
      body: body,
    );

    if (response.statusCode == 200) {
      Utils.successSnackBar(response.statusCode.toString(), response.message);

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      Get.back();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  /// dispose Controller
  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
