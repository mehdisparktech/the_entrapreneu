import 'package:get/get.dart';
import 'package:the_entrapreneu/config/route/app_routes.dart';
import 'package:the_entrapreneu/utils/constants/app_images.dart';
import 'package:the_entrapreneu/utils/enum/enum.dart';

class HistoryController extends GetxController {
  // Tab management
  RxInt selectedTabIndex = 0.obs;

  // History filter management
  RxInt selectedHistoryFilter = 0.obs; // 0 = Completed, 1 = Rejected

  // Sample data for demonstration
  RxList<RequestModel> pendingRequests = <RequestModel>[].obs;
  RxList<RequestModel> upcomingRequests = <RequestModel>[].obs;
  RxList<RequestModel> historyRequests = <RequestModel>[].obs;
  RxList<RequestModel> completedRequests = <RequestModel>[].obs;
  RxList<RequestModel> rejectedRequests = <RequestModel>[].obs;

  // Loading states
  RxBool isLoading = false.obs;
  RxBool isAcceptLoading = false.obs;
  RxBool isRejectLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSampleData();
  }

  // Switch between tabs
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Switch between history filters
  void changeHistoryFilter(int index) {
    selectedHistoryFilter.value = index;
  }

  // Navigate to details screen
  void navigateToDetails(RequestModel request) {
    Get.toNamed(AppRoutes.completeHistoryScreen, arguments: request);
  }

  // Get current tab data
  List<RequestModel> get currentTabData {
    switch (selectedTabIndex.value) {
      case 0:
        return pendingRequests;
      case 1:
        return upcomingRequests;
      case 2:
        // Return filtered history data based on selected filter
        return selectedHistoryFilter.value == 0
            ? completedRequests
            : rejectedRequests;
      default:
        return pendingRequests;
    }
  }

  // Accept request
  Future<void> acceptRequest(String requestId) async {
    try {
      isAcceptLoading.value = true;

      // Find the request in pending list
      final requestIndex = pendingRequests.indexWhere(
        (req) => req.id == requestId,
      );
      if (requestIndex != -1) {
        final request = pendingRequests[requestIndex];

        // Remove from pending and add to upcoming
        pendingRequests.removeAt(requestIndex);
        upcomingRequests.add(request.copyWith(status: StatusType.running));

        // Show success message
        Get.snackbar(
          'Success',
          'Request accepted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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
  Future<void> rejectRequest(String requestId) async {
    try {
      isRejectLoading.value = true;

      // Find the request in pending list
      final requestIndex = pendingRequests.indexWhere(
        (req) => req.id == requestId,
      );
      if (requestIndex != -1) {
        final request = pendingRequests[requestIndex];

        // Remove from pending and add to rejected
        pendingRequests.removeAt(requestIndex);
        rejectedRequests.add(request.copyWith(status: StatusType.rejected));

        // Show success message
        Get.snackbar(
          'Success',
          'Request rejected successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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

  // Load sample data
  void loadSampleData() {
    pendingRequests.addAll([
      RequestModel(
        id: '1',
        title: 'AC Installation',
        subtitle: 'Electrical',
        date: '31st March 25',
        price: '\$100',
        customerName: 'Leslie Alexander',
        customerLocation: 'Cape Town',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
      RequestModel(
        id: '2',
        title: 'AC Installation',
        subtitle: 'Electrical',
        date: '31st March 25',
        price: '\$100',
        customerName: 'Leslie Alexander',
        customerLocation: 'Cape Town',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
      RequestModel(
        id: '3',
        title: 'AC Installation',
        subtitle: 'Electrical',
        date: '31st March 25',
        price: '\$100',
        customerName: 'Leslie Alexander',
        customerLocation: 'Cape Town',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
    ]);

    upcomingRequests.addAll([
      RequestModel(
        id: '4',
        title: 'Plumbing Service',
        subtitle: 'Pipe Repair & Maintenance',
        date: '1st April 25',
        price: '\$80',
        customerName: 'John Doe',
        customerLocation: 'Johannesburg',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
    ]);

    historyRequests.addAll([
      RequestModel(
        id: '5',
        title: 'Electrical Work',
        subtitle: 'Wiring & Installation',
        date: '28th March 25',
        price: '\$150',
        customerName: 'Jane Smith',
        customerLocation: 'Durban',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
    ]);

    // Add sample completed requests
    completedRequests.addAll([
      RequestModel(
        id: '6',
        title: 'AC Installation',
        subtitle: 'Electrical',
        date: '31st March 25',
        price: '\$100',
        customerName: 'Leslie Alexander',
        customerLocation: 'Cape Town',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
      RequestModel(
        id: '7',
        title: 'Plumbing Service',
        subtitle: 'Pipe Repair & Maintenance',
        date: '30th March 25',
        price: '\$80',
        customerName: 'John Doe',
        customerLocation: 'Johannesburg',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
      RequestModel(
        id: '8',
        title: 'Electrical Work',
        subtitle: 'Wiring & Installation',
        date: '29th March 25',
        price: '\$150',
        customerName: 'Jane Smith',
        customerLocation: 'Durban',
        customerImage: AppImages.noImage,
        status: StatusType.running,
      ),
    ]);

    // Add sample rejected requests
    rejectedRequests.addAll([
      RequestModel(
        id: '9',
        title: 'AC Installation',
        subtitle: 'Electrical',
        date: '28th March 25',
        price: '\$100',
        customerName: 'Mike Johnson',
        customerLocation: 'Cape Town',
        customerImage: AppImages.noImage,
        status: StatusType.rejected,
      ),
      RequestModel(
        id: '10',
        title: 'Cleaning Service',
        subtitle: 'Electrical',
        date: '27th March 25',
        price: '\$60',
        customerName: 'Sarah Wilson',
        customerLocation: 'Pretoria',
        customerImage: AppImages.noImage,
        status: StatusType.rejected,
      ),
    ]);
  }
}

// Request model
class RequestModel {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final String price;
  final String customerName;
  final String customerLocation;
  final String customerImage;
  final StatusType status;

  RequestModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.price,
    required this.customerName,
    required this.customerLocation,
    required this.customerImage,
    required this.status,
  });

  RequestModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? date,
    String? price,
    String? customerName,
    String? customerLocation,
    String? customerImage,
    StatusType? status,
  }) {
    return RequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      price: price ?? this.price,
      customerName: customerName ?? this.customerName,
      customerLocation: customerLocation ?? this.customerLocation,
      customerImage: customerImage ?? this.customerImage,
      status: status ?? this.status,
    );
  }
}
