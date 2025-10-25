import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../controller/sign_up_controller.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: CommonText(
          text: 'Add Location',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return Stack(
            children: [
              // Google Map Widget - Full Screen
              GoogleMap(
                initialCameraPosition: controller.initialCameraPosition.value,
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                mapToolbarEnabled: false,
                mapType: MapType.normal,
                compassEnabled: false,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                indoorViewEnabled: true,
                trafficEnabled: false,
                buildingsEnabled: true,
                liteModeEnabled: false,
              ),

              // Bottom Confirmation Button
              Positioned(
                bottom: 24.h,
                left: 20.w,
                right: 20.w,
                child: CommonButton(
                  titleText: 'Apply',
                  onTap: () => controller.confirmLocation(),
                  buttonHeight: 48.h,
                  titleSize: 16,
                  titleWeight: FontWeight.w600,
                  buttonColor: AppColors.primaryColor,
                  titleColor: AppColors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
