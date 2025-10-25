import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/screen/error_screen.dart';
import '../../../../component/text/common_text.dart';
import '../controller/terms_of_services_controller.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/enum/enum.dart';

class TermsOfServicesScreen extends StatelessWidget {
  const TermsOfServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.termsOfServices,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      /// Body Section starts here
      body: GetBuilder<TermsOfServicesController>(
        builder:
            (controller) => switch (controller.status) {
              /// Loading bar here
              Status.loading => const CommonLoader(),

              /// Error Handle here
              Status.error => ErrorScreen(
                onTap:
                    TermsOfServicesController.instance.geTermsOfServicesRepo(),
              ),

              /// Show main data here
              Status.completed => SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: Html(data: controller.data.content),
              ),
            },
      ),
    );
  }
}
