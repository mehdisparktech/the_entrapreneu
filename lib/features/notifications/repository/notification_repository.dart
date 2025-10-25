import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/model/notification_model.dart';

Future<List<NotificationModel>> notificationRepository(int page) async {
  var response = await ApiService.get(
    "${ApiEndPoint.notifications}?page=$page",
  );

  if (response.statusCode == 200) {
    var notificationList = response.data['data'] ?? [];

    List<NotificationModel> list = [];

    for (var notification in notificationList) {
      list.add(NotificationModel.fromJson(notification));
    }

    return list;
  } else {
    return [];
  }
}
