import '../../../services/storage/storage_services.dart';
import '../../../services/api/api_service.dart';
import '../../../config/api/api_end_point.dart';
import '../data/model/chat_list_model.dart';

Future<List<ChatModel>> chatRepository(int page) async {
  var response = await ApiService.get(
    "${ApiEndPoint.baseUrl}${ApiEndPoint.chatRoom}?page=$page",
    header: {"Authorization": "Bearer ${LocalStorage.token}"},
  );

  if (response.statusCode == 200) {
    var chatList = response.data['data'] ?? [];

    List<ChatModel> list = [];

    for (var chat in chatList) {
      list.add(ChatModel.fromJson(chat));
    }

    return list;
  } else {
    return [];
  }
}
