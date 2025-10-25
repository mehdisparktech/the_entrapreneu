import 'package:flutter/material.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';
import '../../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_images.dart';
import '../../component/image/common_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // if (LocalStorage.isLogIn) {
      //   if (LocalStorage.myRole == 'consultant') {
      //     Get.offAllNamed(AppRoutes.doctorHome);
      //   } else {
      //     Get.offAllNamed(AppRoutes.patientsHome);
      //   }
      // } else {
      Get.offAllNamed(AppRoutes.onboarding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonImage(imageSrc: AppImages.logo, size: 350).center,
    );
  }
}
