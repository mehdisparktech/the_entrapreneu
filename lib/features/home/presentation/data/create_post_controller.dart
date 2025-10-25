import 'package:get/get.dart';
import 'package:the_entrapreneu/features/home/presentation/data/post_model.dart';

class CreatePostController extends GetxController {
  var isLoading = true.obs;
  Rx<PostModel?> post = Rx<PostModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadPostDetails();
  }

  void loadPostDetails() {
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      post.value = PostModel(
        id: '1',
        userName: 'Dionne Russell',
        userImage: 'https://via.placeholder.com/150',
        postTime: 'Thursday 02 - 09:00 - Closed',
        title: 'I Need Experienced Plumber',
        location: 'California, Fresno',
        price: '\$100',
        category: 'Home & Property',
        subCategory: 'Plumber',
        date: '01 Sep 2025',
        time: '09:00 Am',
        description: 'We Are Looking For A Skilled And Reliable Plumber To Join Our Team. The Ideal Candidate Will Have Experience In Installing, Repairing, And Maintaining Residential And/Or Commercial Plumbing Systems.',
        responsibilities: [
          'Install, Repair, And Maintain Pipes, Fixtures, And Other Plumbing Systems',
          'Diagnose And Troubleshoot Plumbing Issues',
          'Perform Routine Inspections Of Plumbing And Drainage Systems',
          'Ensure Compliance With Safety And Building Regulations',
          'Provide Excellent Customer Service',
        ],
        requirements: [
          'Proven Plumbing Experience (Minimum [X] Years Preferred)',
          'Valid Plumbing License/Certification (If Required In Your Region)',
          'Strong Knowledge Of Water Supply, Heating, And Sanitation Systems',
          'Ability To Read And Interpret Technical Drawings/ Blueprints',
          'Good Communication And Problem-Solving Skills',
          'Physically Fit And Able To Handle Plumbing Tools/ Equipment',
        ],
        imageUrl: 'https://via.placeholder.com/400x300',
      );
      isLoading.value = false;
    });
  }

  void startConversation() {
    // Handle start conversation logic
    Get.snackbar(
      'Conversation',
      'Starting conversation with ${post.value?.userName}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}