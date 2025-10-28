import 'package:get/get.dart';
import 'package:the_entrapreneu/features/home/presentation/controller/home_controller.dart';
import 'package:the_entrapreneu/features/home/presentation/controller/post_job_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/edit_post_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/edit_service_provider_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/post_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/provider_info_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/edit_post_screen.dart';

import '../../features/auth/change_password/presentation/controller/change_password_controller.dart';
import '../../features/auth/forgot password/presentation/controller/forget_password_controller.dart';
import '../../features/auth/sign in/presentation/controller/sign_in_controller.dart';
import '../../features/auth/sign up/presentation/controller/sign_up_controller.dart';
import '../../features/message/presentation/controller/chat_controller.dart';
import '../../features/message/presentation/controller/message_controller.dart';
import '../../features/notifications/presentation/controller/notifications_controller.dart';
import '../../features/profile/presentation/controller/my_profile_controller.dart';
import '../../features/profile/presentation/controller/profile_controller.dart';
import '../../features/profile/presentation/controller/privacy_policy_controller.dart';
import '../../features/profile/presentation/controller/terms_of_services_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => MessageController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MyProfileController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServicesController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MyPostController(), fenix: true);
    Get.lazyPut(() => EditPostController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => PostJobController(), fenix: true);
    Get.lazyPut(() => ServiceProviderController(), fenix: true);
  }
}
