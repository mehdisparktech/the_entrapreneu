import 'package:get/get.dart';

class ReviewController extends GetxController {
  // Observable variables
  var selectedRating = 0.obs;
  var reviewText = ''.obs;

  // Method to set rating
  void setRating(int rating) {
    selectedRating.value = rating;
  }

  // Method to update review text
  void updateReviewText(String text) {
    reviewText.value = text;
  }

  // Method to submit review
  void submitReview() {
    if (selectedRating.value == 0) {
      Get.snackbar(
        'Rating Required',
        'Please select a rating before submitting',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (reviewText.value.trim().isEmpty) {
      Get.snackbar(
        'Review Required',
        'Please write your review before submitting',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TODO: Implement API call to submit review
    print('Rating: ${selectedRating.value}');
    print('Review: ${reviewText.value}');

    Get.snackbar(
      'Success',
      'Your review has been submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Navigate back or to another screen
    Get.back();
  }
}