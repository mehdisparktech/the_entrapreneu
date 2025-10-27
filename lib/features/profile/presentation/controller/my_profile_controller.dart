import 'package:get/get.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';

class MyProfileController extends GetxController {
  /// User profile data
  String get userName => LocalStorage.myName.isNotEmpty 
      ? LocalStorage.myName 
      : "Shakir Ahmed";
  
  String get userImage => LocalStorage.myImage;
  
  String get userEmail => LocalStorage.myEmail.isNotEmpty 
      ? LocalStorage.myEmail 
      : "Example@gmail.com";

  /// Mock data - In real app, this would come from API
  String get mobile => "+991234546789";
  String get dateOfBirth => "01 January 2000";
  String get gender => "Male";
  String get experience => "5 Years";
  String get address => "California, USA";
  String get about => "Skilled professionals offering reliable, on-demand services to meet your everyday needs quickly and efficiently.";

  /// Navigate to edit profile screen
  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  /// Navigate back
  void goBack() {
    Get.back();
  }
}
