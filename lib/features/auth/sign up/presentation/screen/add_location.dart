import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../controller/sign_up_controller.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return Column(
            children: [
              // Google Map Widget
              GoogleMap(
                initialCameraPosition: controller.initialCameraPosition.value,
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                mapType: MapType.normal,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                indoorViewEnabled: true,
                trafficEnabled: false,
                buildingsEnabled: true,
                liteModeEnabled: false,
              ),
            ],
          );
        },
      ),
    );
  }
}
