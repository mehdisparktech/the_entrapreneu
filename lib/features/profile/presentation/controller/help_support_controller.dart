import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/features/profile/data/model/html_model.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../services/api/api_service.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class HelpSupportController extends GetxController {
  /// Api status check here
  Status status = Status.completed;

  ///  HTML model initialize here
  HtmlModel data = HtmlModel.fromJson({});
  TextEditingController titleController=TextEditingController();
  TextEditingController messageController=TextEditingController();

  /// Privacy Policy Controller instance create here
  static HelpSupportController get instance =>
      Get.put(HelpSupportController());

  /// Privacy Policy Api call here
  supportAdminRepo() async {
    status = Status.loading;
    update();

    var response = await ApiService.post(
        ApiEndPoint.helpSupport,
      body: {
        "title": titleController.text,
        "message": messageController.text,
      }
    );

    if (response.statusCode == 200) {
      data = HtmlModel.fromJson(response.data['data']['content']);

      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode, response.message);
      status = Status.error;
      update();
    }
  }

}
