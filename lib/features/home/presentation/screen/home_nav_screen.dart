import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_entrapreneu/utils/constants/app_colors.dart';

// Import your screens
import '../../../../utils/constants/app_icons.dart';
import '../../../history/presentaion/screen/history_screen.dart';
import '../../../message/presentation/screen/chat_screen.dart';
import '../../../profile/presentation/screen/profile_screen.dart';
import 'home_screen.dart';

class HomeNavController extends GetxController {
  var currentIndex = 0.obs;
}

class HomeNav extends StatelessWidget {
  HomeNav({super.key});

  final HomeNavController controller = Get.put(HomeNavController());

  final List<Widget> screens = [
    HomeScreen(),
    ChatListScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  final List<String> icons = [
    AppIcons.homeIcon,
    AppIcons.chatIcon,
    AppIcons.historyIcon,
    AppIcons.profileIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: screens,
      )),
      bottomNavigationBar: Obx(
            () => Container(
          height: 83.h,
          color: AppColors.primaryColor, // background color
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(icons.length, (index) {
              bool isSelected = controller.currentIndex.value == index;

              return GestureDetector(
                onTap: () => controller.currentIndex.value = index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(isSelected ? 12.w : 0),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    icons[index],
                    height: 26.w,
                    width: 26.w,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.primaryColor : Colors.white.withOpacity(0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
