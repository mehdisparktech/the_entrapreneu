import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/image/common_image.dart';
import 'package:the_entrapreneu/component/other_widgets/item.dart';
import 'package:the_entrapreneu/component/pop_up/common_pop_menu.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/auth/change_password/presentation/screen/change_password_screen.dart';
import 'package:the_entrapreneu/features/profile/presentation/controller/profile_controller.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/help_support_screen.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/my_profile_screen.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/privacy_policy_screen.dart';
import 'package:the_entrapreneu/features/profile/presentation/screen/terms_of_services_screen.dart';
import 'package:the_entrapreneu/services/storage/storage_keys.dart';
import 'package:the_entrapreneu/services/storage/storage_services.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import 'package:the_entrapreneu/utils/constants/app_string.dart';
import 'package:the_entrapreneu/utils/constants/app_icons.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';
import 'package:the_entrapreneu/utils/extensions/extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App Bar Section Starts here
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.profile,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        leading: const SizedBox(),
      ),

      /// Body Section Starts here
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    /// User Profile Image here
                    Center(
                      child: CircleAvatar(
                        radius: 50.sp,
                        backgroundColor: Colors.transparent,
                        child: const ClipOval(
                          child: CommonImage(
                            imageSrc: AppImages.profile,
                            size: 100,
                            defaultImage: AppImages.profile,
                          ),
                        ),
                      ),
                    ),

                    /// User Name here
                    const CommonText(
                      text: LocalStorageKeys.myName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      top: 16,
                      bottom: 4,
                    ),
                    CommonText(
                      text: "UI/UX Designer",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),

                    16.height,

                    /// Edit Profile item here
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileItems.length,
                      itemBuilder: (context, index) {
                        final item = profileItems[index];
                        return Item(
                          imageSrc: item.imageSrc,
                          title: item.title,
                          onTap: item.onTap,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Profile Item Data
final List<ProfileItemData> profileItems = [
  ProfileItemData(
    imageSrc: AppIcons.profile,
    title: 'My Profile',
    onTap: () {
      Get.to(() => const MyProfileScreen());
    },
  ),
  ProfileItemData(
    imageSrc: AppIcons.edit,
    title: 'Change Password',
    onTap: () {
      Get.to(() => const ChangePasswordScreen());
    },
  ),
  ProfileItemData(imageSrc: AppIcons.profile, title: 'My Post', onTap: () {}),
  ProfileItemData(
    imageSrc: AppIcons.privacy,
    title: 'Privacy Policy',
    onTap: () {
      Get.to(() => const PrivacyPolicyScreen());
    },
  ),
  ProfileItemData(
    imageSrc: AppIcons.terms,
    title: 'Terms of Services',
    onTap: () {
      Get.to(() => const TermsOfServicesScreen());
    },
  ),
  ProfileItemData(
    imageSrc: AppIcons.support,
    title: 'Help & Support',
    onTap: () {
      Get.to(() => const HelpSupportScreen());
    },
  ),
  ProfileItemData(
    imageSrc: AppIcons.deleteAccount,
    title: 'Delete Account',
    onTap: () {
      deletePopUp(
        controller: TextEditingController(),
        onTap: () {},
        isLoading: false,
      );
    },
  ),
  ProfileItemData(
    imageSrc: AppIcons.logout,
    title: 'Log Out',
    onTap: () {
      _showLogoutDialog();
    },
  ),
];

// Logout Dialog
void _showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: const CommonText(
        text: 'Log Out',
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      content: CommonText(
        text: 'Are you sure you want to log out?',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
        maxLines: 2,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CommonButton(
                titleText: 'No',
                buttonColor: AppColors.borderColor,
                titleColor: AppColors.black,
                borderColor: AppColors.borderColor,
                onTap: () => Get.back(),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CommonButton(
                titleText: 'Yes',
                buttonColor: AppColors.red,
                borderColor: AppColors.red,
                titleColor: AppColors.white,
                onTap: () {
                  LocalStorage.removeAllPrefData();
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Profile Item Model
class ProfileItemData {
  final String imageSrc;
  final String title;
  final VoidCallback onTap;

  ProfileItemData({
    required this.imageSrc,
    required this.title,
    required this.onTap,
  });
}
