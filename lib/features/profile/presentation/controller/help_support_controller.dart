import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_entrapreneu/features/profile/data/model/html_model.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class HelpSupportController extends GetxController {
  /// Api status check here
  Status status = Status.completed;
  File? image;

  ///  HTML model initialize here
  HtmlModel data = HtmlModel.fromJson({});
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  /// Privacy Policy Controller instance create here
  static HelpSupportController get instance => Get.put(HelpSupportController());

  /// Image picker here
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  /// Support Admin Api call here
  supportAdminRepo() async {
    // Validate inputs
    if (titleController.text.trim().isEmpty) {
      Utils.errorSnackBar(400, "Please enter issue title");
      return;
    }

    if (messageController.text.trim().isEmpty) {
      Utils.errorSnackBar(400, "Please enter description");
      return;
    }

    if (image == null) {
      Utils.errorSnackBar(400, "Please attach a file");
      return;
    }

    status = Status.loading;
    update();

    var response = await ApiService.multipart(
      ApiEndPoint.helpSupport,
      body: {
        "title": titleController.text.trim(),
        "description": messageController.text.trim(),
      },
      imagePath: image?.path,
      imageName: 'image',
    );

    if (response.statusCode == 200) {
      Utils.successSnackBar(
        "Success",
        "Support request submitted successfully",
      );

      // Clear form
      titleController.clear();
      messageController.clear();
      image = null;

      status = Status.completed;
      update();

      // Go back
      Get.back();
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
      status = Status.error;
      update();
    }
  }
}
