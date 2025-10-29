import 'package:get/get.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/utils/enum/enum.dart';
import 'history_controller.dart';

class HistoryDetailsController extends GetxController {
  // Selected request data
  Rx<RequestModel?> selectedRequest = Rx<RequestModel?>(null);

  // Loading states
  RxBool isAcceptLoading = false.obs;
  RxBool isRejectLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get the request data passed from navigation
    final arguments = Get.arguments;
    if (arguments != null && arguments is RequestModel) {
      selectedRequest.value = arguments;
    }
  }

  // Set selected request
  void setSelectedRequest(RequestModel request) {
    selectedRequest.value = request;
  }

  // Accept request
  Future<void> acceptRequest() async {
    if (selectedRequest.value == null) return;

    try {
      isAcceptLoading.value = true;

      // Get the history controller to update the data
      final historyController = Get.find<HistoryController>();
      await historyController.acceptRequest(selectedRequest.value!.id);

      // Update local data
      selectedRequest.value = selectedRequest.value!.copyWith(
        status: StatusType.running,
      );

      // Show success message
      Get.snackbar(
        'Success',
        'Request accepted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate back
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to accept request',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAcceptLoading.value = false;
    }
  }

  // Reject request
  Future<void> rejectRequest() async {
    if (selectedRequest.value == null) return;

    try {
      isRejectLoading.value = true;

      // Get the history controller to update the data
      final historyController = Get.find<HistoryController>();
      await historyController.rejectRequest(selectedRequest.value!.id);
      Get.toNamed(
        AppRoutes.firstMessageScreen,
        arguments: selectedRequest.value,
      );

      // Show success message
      Get.snackbar(
        'Success',
        'Request rejected successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate back
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to reject request',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isRejectLoading.value = false;
    }
  }

  // Get service status text and color
  String get serviceStatusText {
    switch (selectedRequest.value?.status) {
      case StatusType.running:
        return 'Running';
      case StatusType.rejected:
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  // Get payment status (for demo purposes, showing as complete)
  String get paymentStatusText => 'Complete';

  // Check if request is pending (to show action buttons)
  bool get isPendingRequest =>
      selectedRequest.value?.status == StatusType.running;

  // Check if request is rejected (to show reject reason field)
  bool get isRejectedRequest =>
      selectedRequest.value?.status == StatusType.rejected;

  // Check if request is completed (to show completed info)
  bool get isCompletedRequest =>
      selectedRequest.value?.status == StatusType.running;
}
