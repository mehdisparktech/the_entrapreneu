import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/notification_model.dart';
import '../../repository/notification_repository.dart';

class NotificationsController extends GetxController {
  /// Notification List
  List notifications = [];

  /// Notification Loading Bar
  bool isLoading = false;

  /// Notification more Data Loading Bar
  bool isLoadingMore = false;

  /// No more notification data
  bool hasNoData = false;

  /// page no here
  int page = 0;

  /// Notification Scroll Controller
  ScrollController scrollController = ScrollController();

  /// Notification More data Loading function

  // Initialize with demo notifications
  @override
  void onInit() {
    super.onInit();

    getNotificationsRepo();
    moreNotification();
    // Add demo notifications
    notifications.addAll([
      NotificationModel(
        id: 'n1',
        message: 'Shakir Ahmed Accept Your Custom Offer',
        linkId: 'post123',
        type: 'Accept Offer',
        role: 'user',
        receiver: 'current_user_id',
        v: 0,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationModel(
        id: 'n2',
        message: 'Shakir Ahmed Reject Your Custom Offer',
        linkId: 'comment456',
        type: 'Reject Offer',
        role: 'user',
        receiver: 'current_user_id',
        v: 0,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: 'n3',
        message: 'New message from Tech Support',
        linkId: 'chat789',
        type: 'Message Request',
        role: 'support',
        receiver: 'current_user_id',
        v: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        id: 'n4',
        message: 'Shakir Ahmed Accept Your Custom Offer',
        linkId: 'account',
        type: 'Accept Offer',
        role: 'system',
        receiver: 'current_user_id',
        v: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      NotificationModel(
        id: 'n5',
        message: 'New feature update available! Check out what\'s new',
        linkId: 'app_update',
        type: 'update',
        role: 'admin',
        receiver: 'all_users',
        v: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ]);
  }

  void moreNotification() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isLoadingMore || hasNoData) return;
        isLoadingMore = true;
        update();
        page++;
        List<NotificationModel> list = await notificationRepository(page);
        if (list.isEmpty) {
          hasNoData = true;
        } else {
          notifications.addAll(list);
        }
        isLoadingMore = false;
        update();
      }
    });
  }

  /// Notification data Loading function
  getNotificationsRepo() async {
    return;
    if (isLoading || hasNoData) return;
    isLoading = true;
    update();

    page++;
    List<NotificationModel> list = await notificationRepository(page);
    if (list.isEmpty) {
      hasNoData = true;
    } else {
      notifications.addAll(list);
    }
    isLoading = false;
    update();
  }

  /// Notification Controller Instance create here
  static NotificationsController get instance =>
      Get.put(NotificationsController());
}
