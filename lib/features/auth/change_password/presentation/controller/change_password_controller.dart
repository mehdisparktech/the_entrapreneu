import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';

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
    isLoading = true;
    update();

    Map<String, String> body = {
      "currentPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text,
      "confirmPassword": confirmPasswordController.text,
    };
    Map<String, String> header = {
      "Authorization": "Bearer ${LocalStorage.token}",
    };
    var response = await ApiService.post(
      ApiEndPoint.changePassword,
      body: body,
      header: header,
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
