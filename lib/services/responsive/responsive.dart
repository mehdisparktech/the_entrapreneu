import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive {
  static BuildContext context = Get.context!;

  static double isSize() => MediaQuery.of(context).size.width;

  static bool isMobile() => MediaQuery.of(context).size.width < 600;

  static bool isTablet() =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width >= 600;

  static bool isDesktop() => MediaQuery.of(context).size.width >= 1024;

  static init(BuildContext ctx) {
    context = ctx;
  }
}
