import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';
import '../../../message/data/model/chat_message_model.dart';
import '../../../message/data/model/message_model.dart';

class FirstMessageController extends GetxController {
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

  File? selectedAttachment;
  String? attachmentType; // 'image' or 'file'

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  static FirstMessageController get instance => Get.put(FirstMessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  Future<void> getMessageRepo() async {
    return;
    if (page == 1) {
      messages.clear();
      status = Status.loading;
      update();
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

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        selectedAttachment = File(image.path);
        attachmentType = 'image';
        update();

        // Send image message
        await sendMessageWithAttachment();

        Get.snackbar(
          'Success',
          'Image attached',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        selectedAttachment = File(image.path);
        attachmentType = 'image';
        update();

        // Send image message
        await sendMessageWithAttachment();

        Get.snackbar(
          'Success',
          'Photo captured',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to capture photo: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendMessageWithAttachment() async {
    if (selectedAttachment == null) return;

    // Add message with attachment to UI
    messages.insert(
      0,
      ChatMessageModel(
        time: DateTime.now(),
        text: "📎 Image attachment",
        image: LocalStorage.myImage,
        isMe: true,
      ),
    );

    update();

    // TODO: Upload attachment to server and get URL
    // var uploadedUrl = await uploadAttachment(selectedAttachment!);

    var body = {
      "chat": chatId,
      "message": "📎 Image attachment",
      "sender": LocalStorage.userId,
      // "attachment": uploadedUrl,
      // "attachmentType": attachmentType,
    };

    SocketServices.emitWithAck("add-new-message", body, (data) {
      if (kDebugMode) {
        print("Message with attachment sent: $data");
      }
    });

    // Clear attachment
    selectedAttachment = null;
    attachmentType = null;
    update();
  }

  addNewMessage() async {
    if (messageController.text.trim().isEmpty) return;

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

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
}