import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../../../services/api/api_service.dart';
import '../../../../services/socket/socket_service.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enum/enum.dart';
import '../../../message/data/model/chat_message_model.dart';
import '../../../message/data/model/message_model.dart';
import '../../data/view_data.dart';

class FirstMessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;
  bool isUploadingImage = false;
  String? video;

  List messages = [];

  String chatId = "";
  String chatRoomId = "";
  String name = "";
  String image = "";
  String serviceId = "";

  int page = 1;
  int currentIndex = 0;
  Status status = Status.completed;

  bool isMessage = false;
  bool isInputField = false;

  File? selectedAttachment;
  String? attachmentType;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  ViewData? post;

  final ImagePicker _picker = ImagePicker();

  static FirstMessageController get instance => Get.put(FirstMessageController());

  MessageModel messageModel = MessageModel.fromJson({});

  @override
  void onInit() {
    super.onInit();

    // Get arguments from previous screen
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      chatId = args['chatRoomId'] ?? '';
      chatRoomId = args['chatRoomId'] ?? '';
      name = args['otherUserName'] ?? '';
      image = args['otherUserImage'] ?? '';
      serviceId = args['serviceId'] ?? '';
      print("chat id 😍😍😍😍 $chatId");
      print("chat room id 😍😍😍😍 $chatRoomId");
      print("service id 😍😍😍😍 $serviceId");

      // Get initial message if exists
      String initialMessage = args['initialMessage'] ?? '';
      if (initialMessage.isNotEmpty) {
        messageController.text = initialMessage;
      }
    }

    getCard();

    // Load messages if chatId exists
    if (chatId.isNotEmpty) {
      getMessageRepo();
    }
  }

  // Scroll to bottom with animation
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> getMessageRepo() async {
    if (chatId.isEmpty) return;

    isLoading = true;
    update();

    try {
      var response = await ApiService.get("/message/$chatId");

      if (response.statusCode == 200) {
        var data = response.data['data'];

        messages.clear();

        // Create a temporary list to hold all messages
        List<ChatMessageModel> tempMessages = [];

        for (var messageData in data) {
          tempMessages.add(
            ChatMessageModel(
              time: DateTime.parse(messageData['createdAt']).toLocal(),
              text: messageData['text'] ?? '',
              image: messageData['sender']['image'] ?? '',
              messageImage: messageData['image'],
              isNotice: false,
              isMe: LocalStorage.userId == messageData['sender']['_id'],
            ),
          );
        }

        // Sort messages by time - oldest to newest
        tempMessages.sort((a, b) => a.time.compareTo(b.time));

        // Add sorted messages to main list
        messages.addAll(tempMessages);

        // Listen for new messages via socket
        listenMessage(chatId);

        isLoading = false;
        update();

        // Scroll to bottom after loading messages
        scrollToBottom();
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
        isLoading = false;
        update();
      }
    } catch (e) {
      print('Error fetching messages: $e');
      Get.snackbar(
        'Error',
        'Failed to load messages',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading = false;
      update();
    }
  }

  void getCard() async {
    try {
      var response = await ApiService.get("/posts/$serviceId");

      if (response.statusCode == 200) {
        final viewPostResponse = ViewPostResponseModel.fromJson(response.data);
        post = viewPostResponse.data;
      } else {
        Utils.errorSnackBar(response.statusCode.toString(), response.message);
      }
    } catch (e) {
      print('Error fetching card: $e');
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

        await sendMessageWithImage();
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

        await sendMessageWithImage();
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

  Future<void> sendMessageWithImage() async {
    if (selectedAttachment == null) return;

    // Add uploading message at the BOTTOM
    messages.add(
      ChatMessageModel(
        time: DateTime.now(),
        text: "",
        image: LocalStorage.myImage,
        messageImage: selectedAttachment!.path,
        isMe: true,
        isUploading: true,
      ),
    );

    isUploadingImage = true;
    update();
    scrollToBottom(); // Scroll to show uploading message

    try {
      FormData formData = FormData.fromMap({
        'chatId': chatRoomId,
        'service': serviceId,
        'image': await MultipartFile.fromFile(
          selectedAttachment!.path,
          filename: selectedAttachment!.path.split('/').last,
        ),
      });

      final response = await ApiService.post(
        "message/create",
        body: formData,
      );

      // Remove uploading message from BOTTOM
      messages.removeLast();

      if (response.statusCode == 200) {
        var messageData = response.data['data'];
        // Add actual message at BOTTOM
        messages.add(
          ChatMessageModel(
            time: DateTime.parse(messageData['createdAt']).toLocal(),
            text: messageData['text'] ?? '',
            image: LocalStorage.myImage,
            messageImage: messageData['image'],
            isMe: true,
            isUploading: false,
          ),
        );

        update();
        scrollToBottom(); // Scroll to show new message

        Get.snackbar(
          'Success',
          'Image sent successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        print("Image sent successfully");
      } else {
        update();
        Get.snackbar(
          'Error',
          'Failed to send image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (messages.isNotEmpty && messages.last.isUploading == true) {
        messages.removeLast();
      }
      update();

      print('Error sending image: $e');
      Get.snackbar(
        'Error',
        'Failed to send image: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      selectedAttachment = null;
      attachmentType = null;
      isUploadingImage = false;
      update();
    }
  }

  Future<void> addNewMessage() async {
    if (messageController.text.trim().isEmpty) return;

    isMessage = true;
    update();

    // Add message at BOTTOM
    messages.add(
      ChatMessageModel(
        time: DateTime.now(),
        text: messageController.text,
        image: LocalStorage.myImage,
        isMe: true,
      ),
    );

    isMessage = false;
    update();
    scrollToBottom(); // Scroll to show new message

    print("chat room id 😍😍😍😍 $chatRoomId");
    print("service id 😍😍😍😍 $serviceId");

    var body = {
      "chatId": chatRoomId,
      "text": messageController.text,
      "service": serviceId,
    };

    messageController.clear();

    final response = await ApiService.post("message/create", body: body);

    if (response.statusCode == 200) {
      print("Message sent successfully");
    } else {
      Get.snackbar(
        'Error',
        'Failed to send message',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  listenMessage(String chatId) async {
    SocketServices.on('getMessage::$chatId', (data) {
      // Add new message at BOTTOM
      messages.add(
        ChatMessageModel(
          isNotice: data['messageType'] == "notice" ? true : false,
          time: DateTime.parse(data['createdAt']).toLocal(),
          text: data['text'] ?? data['message'] ?? '',
          image: data['sender']['image'] ?? '',
          messageImage: data['image'],
          isMe: LocalStorage.userId == data['sender']['_id'],
        ),
      );

      update();
      scrollToBottom(); // Scroll to show new message from socket
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