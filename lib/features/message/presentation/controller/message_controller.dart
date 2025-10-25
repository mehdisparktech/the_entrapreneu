import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/model/message_model.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';

class MessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  String? video;

  List messages = [];

  String chatId = "";
  String name = "";

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  static MessageController get instance => Get.put(MessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  Future<void> getMessageRepo() async {
    // Add demo messages for testing
    if (page == 1) {
      messages.clear();
      status = Status.loading;
      update();
      
      // Add demo messages
      messages.addAll([
        ChatMessageModel(
          time: DateTime.now().subtract(const Duration(minutes: 2)),
          text: "Hello there! How can I help you today?",
          image: "https://randomuser.me/api/portraits/women/44.jpg",
          isMe: false,
        ),
        ChatMessageModel(
          time: DateTime.now().subtract(const Duration(minutes: 1, seconds: 45)),
          text: "I'm testing the chat interface. This is a demo message.",
          image: "",
          isMe: true,
        ),
        ChatMessageModel(
          time: DateTime.now().subtract(const Duration(minutes: 1, seconds: 30)),
          text: "That's great! Let me know if you need any assistance.",
          image: "https://randomuser.me/api/portraits/women/44.jpg",
          isMe: false,
        ),
        ChatMessageModel(
          time: DateTime.now().subtract(const Duration(minutes: 1)),
          text: "Can you show me how the long messages look?",
          image: "",
          isMe: true,
        ),
        ChatMessageModel(
          time: DateTime.now().subtract(const Duration(seconds: 30)),
          text: "Of course! This is a longer message to demonstrate how the chat bubble handles text wrapping. The message should automatically adjust its height to fit the content while maintaining proper padding and alignment.",
          image: "https://randomuser.me/api/portraits/women/44.jpg",
          isMe: false,
        ),
      ]);
      
      status = Status.completed;
      update();
      return;
    }

    var response = await ApiService.get(
      "${ApiEndPoint.messages}?chatId=$chatId&page=$page&limit=15",
    );

    if (response.statusCode == 200) {
      var data = response.data['data']['attributes']['messages'];

      for (var messageData in data) {
        messageModel = MessageModel.fromJson(messageData);

        messages.add(
          ChatMessageModel(
            time: messageModel.createdAt.toLocal(),
            text: messageModel.message,
            image: messageModel.sender.image,
            isNotice: messageModel.type == "notice" ? true : false,
            isMe: LocalStorage.userId == messageModel.sender.id ? true : false,
          ),
        );
      }

      page = page + 1;
      status = Status.completed;
      update();
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  addNewMessage() async {
    isMessage = true;
    update();

    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: messageController.text,
        image: LocalStorage.myImage,
        isMe: true,
      ),

      // ChatMessageModel(
      //     currentTime.format(context).toString(),
      //     controller.messageController.text,
      //     true),
    );

    isMessage = false;
    update();

    var body = {
      "chat": chatId,
      "message": messageController.text,
      "sender": LocalStorage.userId,
    };

    messageController.clear();

    SocketServices.emitWithAck("add-new-message", body, (data) {
      if (kDebugMode) {
        print(
          "===============================================================> Received acknowledgment: $data",
        );
      }
    });
  }

  listenMessage(String chatId) async {
    SocketServices.on('new-message::$chatId', (data) {
      status = Status.loading;
      update();

      var time = data['createdAt'].toLocal();
      messages.insert(
        0,
        ChatMessageModel(
          isNotice: data['messageType'] == "notice" ? true : false,
          time: time,
          text: data['message'],
          image: data['sender']['image'],
          isMe: false,
        ),
      );

      status = Status.completed;
      update();
    });
  }

  void isEmoji(int index) {
    currentIndex = index;
    isInputField = isInputField;
    update();
  }
}
