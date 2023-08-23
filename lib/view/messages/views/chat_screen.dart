// ignore_for_file: avoid_print, duplicate_ignore
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:vc/controller/chat/chat_controller.dart';
import '../../../helper/caching_data.dart';
import '../../../model/chat/all_chat_model.dart';
import '../../../model/chat/latest_message_model.dart';
import '../../../model/chat/send_message_model.dart';
import '../../../theme/constant/sized.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/audio_chat_bubble.dart';
import '../widgets/custom_bar.dart';
import '../widgets/image_chat_bubble.dart';
import '../widgets/text_chat_bubble.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  final LatestMessageDataModel dataModel;
  const ChatScreen({super.key, required this.dataModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatController controller;
  @override
  void initState() {
    controller = Get.put(ChatController());
    getPusherInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ChatAppBar(),
            StreamBuilder(
              stream: controller
                  .chatMessage(
                      id: widget.dataModel.otherUserId, context: context)
                  .asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final ChatMessageModel chatModel =
                      snapshot.data as ChatMessageModel;
                  controller.chatMessagesList.clear();
                  for (int index = 0;
                      index < chatModel.data.messages.length;
                      index++) {
                    final message = chatModel.data.messages[index];

                    if (message.attachments.isNotEmpty &&
                        GetUtils.isImage(message.attachments.first.url)) {
                      controller.chatMessagesList.add(ImageChatBubble(
                          image: message.attachments.first.url,
                          sender: message.fromLoggedUser,
                          id: index.toString()));
                    } else if (message.body.isNotEmpty) {
                      controller.chatMessagesList.add(TextChatBubble(
                        message: message.body,
                        sender: message.fromLoggedUser,
                      ));
                    } else if (message.attachments.isNotEmpty &&
                            GetUtils.isAudio(message.attachments.first.url) ||
                        message.attachments.first.url
                            .toLowerCase()
                            .endsWith(".bin")) {
                      controller.chatMessagesList.add(AudioChatBubble(
                        audio: message.attachments.first.url,
                        sender: message.fromLoggedUser,
                      ));
                    }
                  }
                  return Expanded(
                    child: GetBuilder<ChatController>(builder: (_) {
                      return ListView.builder(
                        itemCount: controller.chatMessagesList.length,
                        itemBuilder: (context, index) {
                          return controller.chatMessagesList[index];
                        },
                      );
                    }),
                  );
                } else {
                  return SizedBox(
                    height: screenUtil.setHeight(585),
                  );
                }
              },
            ),
            SizedBox(
              height: screenUtil.setHeight(85),
              child: ChatBottomBar(dataModel: widget.dataModel),
            ),
          ],
        ),
      ),
    );
  }

  void getPusherInit() async {
    Channel? channel;
    PusherOptions options = PusherOptions(
      auth: PusherAuth(
        'https://api.babishisha.com/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer ${loginData!.token}',
          'Content-Type': 'application/json',
        },
      ),
      host: 'https://api.babishisha.com',
      cluster: 'mt1',
      encrypted: true,
    );

    PusherClient pusher =
        PusherClient('14224c2f3aa03933a8eb', options, enableLogging: true);

    channel = pusher.subscribe('private-chat.${loginData!.userData.id}');

    await channel.bind('MessageSentEvent', (PusherEvent? event) {
      if (event!.eventName == 'MessageSentEvent') {
        Widget? messageChatBubble;

        final newMessage =
            MessageContent.fromJson(json.decode(event.data ?? ''));

        if (newMessage.attachments!.isNotEmpty &&
            GetUtils.isImage(newMessage.attachments!.first.url)) {
          messageChatBubble = ImageChatBubble(
              image: newMessage.attachments!.first.url,
              sender: newMessage.fromLoggedUser,
              id: controller.chatMessagesList.length.toString());
        } else if (newMessage.body.isNotEmpty) {
          messageChatBubble = TextChatBubble(
            message: newMessage.body,
            sender: newMessage.fromLoggedUser,
          );
        } else if (newMessage.attachments!.isNotEmpty &&
                GetUtils.isAudio(newMessage.attachments!.first.url) ||
            newMessage.attachments!.first.url.toLowerCase().endsWith(".m4a")) {
          messageChatBubble = AudioChatBubble(
            audio: newMessage.attachments!.first.url,
            sender: newMessage.fromLoggedUser,
          );
        }

        controller.chatMessagesList.add(messageChatBubble!);
        print(controller.chatMessagesList);
        controller.update();
      }
    });
    await pusher.connect();
    pusher.onConnectionStateChange((state) {
      print(state);
    });
    pusher.onConnectionError((error) {
      // ignore: avoid_print
      print("error: ${error!.message}");
    });
  }
}
