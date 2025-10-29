import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_entrapreneu/features/auth/sign%20up/presentation/widget/success_profile.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/helpers/other_helper.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/storage/storage_keys.dart';
import '../../../../../config/api/api_end_point.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/app_utils.dart';

class SignUpController extends GetxController {
  /// Sign Up Form Key

  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;

  GoogleMapController? mapController;
  Position? currentPosition;
  var markers = <Marker>{};
  var initialCameraPosition = const CameraPosition(
    target: LatLng(23.8103, 90.4125), // Dhaka, Bangladesh default
    zoom: 14.0,
  ).obs;

  Timer? _timer;
  int start = 0;

  String time = "";

  List selectedOption = ["User", "Consultant"];

  String selectRole = "SERVICE_PROVIDER";
  String countryCode = "+880";
  String? image;

  String signUpToken = '';

  static SignUpController get instance => Get.put(SignUpController());

  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? "Namimul Hassan" : "",
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "developernaimul00@gmail.com" : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController numberController = TextEditingController(
    text: kDebugMode ? '1865965581' : '',
  );
  TextEditingController otpController = TextEditingController(
    text: kDebugMode ? '123456' : '',
  );

  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedGender = 'Male';
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = DateFormat('dd MMMM yyyy').format(picked);
      update();
    }
  }

  onCountryChange(Country value) {
    countryCode = value.dialCode.toString();
  }

  setSelectedRole(value) {
    selectRole = value;
    update();
  }

  openGallery() async {
    image = await OtherHelper.openGallery();
    update();
  }

  signUpUser(GlobalKey<FormState> signUpFormKey) async {
    if (!signUpFormKey.currentState!.validate()) return;
    isLoading = true;
    update();
    Map<String, String> body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "role": selectRole,
    };

    var response = await ApiService.post(ApiEndPoint.signUp, body: body);

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.verifyUser);
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();
    Map<String, String> body = {
      "email": emailController.text,
      "oneTimeCode": otpController.text,
    };
    Map<String, String> header = {"SignUpToken": "signUpToken $signUpToken"};
    var response = await ApiService.post(
      ApiEndPoint.verifyEmail,
      body: body,
      header: header,
    );

    if (response.statusCode == 200) {
      var data = response.data;

      LocalStorage.token = data['data']["accessToken"];
      LocalStorage.isLogIn = true;

      LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
      LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);

      Get.toNamed(AppRoutes.completeProfile);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoadingVerify = false;
    update();
  }

  // Location permission
  Future<void> _requestLocationPermission() async {
    try {
      // Check current permission status
      var status = await Permission.location.status;

      // If permission not determined yet or denied, request it
      if (status.isDenied || status.isRestricted || status.isLimited) {
        // Request permission - this will show the system dialog
        status = await Permission.location.request();
      }

      if (status.isGranted || status.isLimited) {
        // Permission granted, get location
        await getCurrentLocation();
      } else if (status.isDenied) {
        // User denied the permission
        Get.snackbar(
          "Permission Denied",
          "Location permission is needed to show your position",
          backgroundColor: AppColors.red.withOpacity(0.9),
          colorText: AppColors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
              _requestLocationPermission(); // Ask again
            },
            child: const Text(
              "Retry",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print("Permission error: $e");
    }
  }

  // Location methods
  Future<void> getCurrentLocation() async {
    try {
      // Check permission first
      final permissionStatus = await Permission.location.status;
      if (!permissionStatus.isGranted) {
        await _requestLocationPermission();
        return;
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          "Location Service",
          "Please enable location services in your device settings",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Show loading indicator
      Get.snackbar(
        "Getting Location",
        "Please wait...",
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        colorText: AppColors.white,
        duration: const Duration(seconds: 1),
        showProgressIndicator: true,
      );

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      currentPosition = position;

      // Move camera to current location
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          15.0,
        ),
      );

      Get.snackbar(
        "Location Updated",
        "Moved to your current location",
        backgroundColor: AppColors.secondary,
        colorText: AppColors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to get location. Please check your GPS and try again.",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print("✅ Google Map Created Successfully");
    // Location will be fetched after permission is granted
  }

  // Confirm location and add marker
  void confirmLocation() async {
    try {
      // Get current camera position
      if (mapController != null) {
        final LatLng center = await mapController!.getVisibleRegion().then(
          (bounds) => LatLng(
            (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
            (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
          ),
        );

        // Add marker at center
        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('selected_location'),
            position: center,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: const InfoWindow(title: 'Selected Location'),
          ),
        );
        update();

        // Show success message
        Get.snackbar(
          "Location Confirmed",
          "Your location has been selected successfully",
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to next screen or save location
        // Get.toNamed(AppRoutes.nextScreen);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to confirm location. Please try again.",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> updateProfile() async {
    isLoading = true;
    update();
    Map<String, String> body = {
      "birthDate": dateController.text,
      "lat": currentPosition?.latitude.toString() ?? "",
      "log": currentPosition?.longitude.toString() ?? "",
      "gender": selectedGender,
    };

    var response = await ApiService.patch(ApiEndPoint.user, body: body);

    if (response.statusCode == 200) {
      SuccessProfileDialogHere.show(
        Get.context!,
        title: "Your Registration Successfully Complete.",
      );
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  @override
  void dispose() {
    _timer?.cancel();
    mapController?.dispose();
    super.dispose();
  }
}
