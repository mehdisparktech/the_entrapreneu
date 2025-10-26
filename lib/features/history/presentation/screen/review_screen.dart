import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_entrapreneu/component/button/common_button.dart';
import 'package:the_entrapreneu/component/text/common_text.dart';
import 'package:the_entrapreneu/features/history/presentation/widgets/success_dialog.dart';
import 'package:the_entrapreneu/utils/constants/success_dialog.dart';

import '../../../../utils/constants/app_colors.dart';
import 'review_controller.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({Key? key}) : super(key: key);

  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Center(
                child: Text(
                  'Give Your Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Star Rating
              Center(
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => controller.setRating(index + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(
                          index < controller.selectedRating.value
                              ? Icons.star
                              : Icons.star_border,
                          size: 40,
                          color: index < controller.selectedRating.value
                              ? const Color(0xFF1E5AA8)
                              : const Color(0xFF1E5AA8),
                        ),
                      ),
                    );
                  }),
                )),
              ),

              const SizedBox(height: 40),

              // Text field label
              CommonText(
                  text: "Type Your Review",
                fontSize: 14,
                color: AppColors.textPrimary,
              ),

              const SizedBox(height: 12),

              // Review text field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: 8,
                  onChanged: (value) => controller.updateReviewText(value),
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'Type Your Review',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Share button
              CommonButton(
                  titleText: "Share",
                buttonRadius: 12,
                buttonHeight: 48,
                onTap: () {
                    SuccessReview.show(
                        Get.context!, title: "ksdjfkl"
                    );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}