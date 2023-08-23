// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/chat/latest_message_model.dart';
import 'package:vc/services/chat_service/latest_message_service.dart';
import 'package:vc/services/chat_service/send_message_services.dart';
import 'package:vc/services/chat_service/video_call.dart';
import 'package:vc/theme/constant/constants.dart';
import '../../model/chat/all_chat_model.dart';
import '../../model/chat/delete_message_model.dart';
import '../../model/chat/send_message_model.dart';
import '../../model/response_model.dart';
import '../../services/chat_service/chat_service.dart';
import '../../services/chat_service/delete_message_service.dart';
import '../../services/chat_service/seen_message_service.dart';


ApiService apiService = ApiService();


class ChatController extends GetxController {
  LatestMessagesService latestMessagesService =
      LatestMessagesService(apiService: apiService);
  SeenMessagesService seenMessagesService =
      SeenMessagesService(apiService: apiService);
  DeleteMessageService deleteMessageService =
      DeleteMessageService(apiService: apiService);
  ChatMessageService chatMessageService =
      ChatMessageService(apiService: apiService);
  SendMessagesService sendMessagesService =
      SendMessagesService(apiService: apiService);

  List<Widget> chatMessagesList = [];

  List<Widget> latestMessagesList = [];
  bool showEmogis = false;
  String selectedEmoji = '';
  final TextEditingController message = TextEditingController();
  final TextEditingController userId = TextEditingController();
  final TextEditingController messageTextController = TextEditingController();
  bool msgLen = false;

  Future<LatestMessagesModel?> latestMessage(
      {required BuildContext context}) async {
    final data = await latestMessagesService.latestMessages();
    if (data['type'] == 'success' && data['code'] == 200) {
      return LatestMessagesModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }


  Future<ChatMessageModel?> chatMessage(
      {required int id, required BuildContext context}) async {
    final data = await chatMessageService.chatMessage(id: id);
    if (data != null && data['type'] == 'success' && data['code'] == 200) {
      return ChatMessageModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }


  Future<DeleteMessageModel?> deleteMessage(
      {required int id, required BuildContext context}) async {
    final data = await deleteMessageService.deleteMessage(id: id);
    if (data['type'] == 'success' && data['code'] == 200) {
      ShowBanner.showBanner(context: context, text: data['message']);
      return DeleteMessageModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<ResponseModel?> seenMessages(
      {required int otherUserId, required BuildContext context}) async {
    final data = await seenMessagesService.seenMessages(body: {
      'other_user_id': otherUserId.toString(),
    });

    if (data != null && data['type'] == 'success' && data['code'] == 200) {
      return ResponseModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<Map?> getVideoCallToken({
    required String channelName,
    required BuildContext context,
  }) async {
    final data = await GetVideoCallToken().getVideoCallToken(
      body: {
        'channelName': channelName,
      },
      token: loginData!.token,
    );
    if (data['status'] == 200) {
      return data['data'];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('try again')));
    }
    return null;
  }

  checkMsgLen({required int textLen}) {
    if (textLen > 0) {
      msgLen = true;
    } else {
      msgLen = false;
    }
    update();
  }

  void isEmojiOff() {
    if (showEmogis) {
      showEmogis = false;
    } else {
      showEmogis = true;
    }
    update();
  }

  Future<SendMessageModel?> sendMessages({
    required BuildContext context,
    required String messages,
    String? media,
  }) async {
    final data = await sendMessagesService.sendMessages(
      body: {
        messages.isNotEmpty ? 'body' : 'null': messages,
        // ignore: prefer_if_null_operators
        media != null ? 'media' : 'null': media != null ? media : '',
      },
    );
    if (data['type'] == 'success' && data['code'] == 201) {
      return SendMessageModel.fromJson(data);
    } else if (data['data']['body'] != null) {
      ShowBanner.showBanner(context: context, text: data['data']['body']);
    } else if (data['data']['media'] != null) {
      ShowBanner.showBanner(context: context, text: data['data']['media']);
    } else {
      ShowBanner.showBanner(context: context, text: data['type']);
    }
    return null;
  }
}
