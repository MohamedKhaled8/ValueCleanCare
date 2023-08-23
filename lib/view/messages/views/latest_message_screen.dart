// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, avoid_types_as_parameter_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:vc/controller/chat/chat_controller.dart';
import '../../../helper/caching_data.dart';
import '../../../model/chat/latest_message_model.dart';
import '../../../theme/constant/sized.dart';
import '../../../widgets/default_appBar.dart';
import '../widgets/latest_message_card.dart';
import '../widgets/store_message.dart';
import 'chat_screen.dart';

class LatestMessagesScreen extends StatefulWidget {
  const LatestMessagesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LatestMessagesScreen> createState() => _LatestMessagesScreenState();
}

class _LatestMessagesScreenState extends State<LatestMessagesScreen> {
  @override
  void initState() {
    getPusherInit();
    super.initState();
  }

  final ChatController controller = Get.put(ChatController());

  late LatestMessagesModel latestMessagesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        size: 120,
        text: 'Messages'.tr,
        screenUtil: screenUtil,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: controller.latestMessage(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      controller.latestMessagesList.clear();
                      latestMessagesModel =
                          snapshot.data as LatestMessagesModel;
                      for (int i = 0;
                          i < latestMessagesModel.data.length;
                          i++) {
                        controller.latestMessagesList.add(
                          LatestMessageCard(
                              latestMessagesModel: latestMessagesModel.data[i]),
                        );
                        controller.update();
                      }
                      //////
                      if (latestMessagesModel.data.isNotEmpty) {
                        return GetBuilder<ChatController>(builder: (_) {
                          // controller.update();
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => ChatScreen(
                                        dataModel:
                                            latestMessagesModel.data[index]));
                                    controller.seenMessages(
                                        context: context,
                                        otherUserId: latestMessagesModel
                                            .data[index].otherUserId);
                                  },
                                  child: controller.latestMessagesList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: screenUtil.setHeight(5),
                                );
                              },
                              itemCount: controller.latestMessagesList.length);
                        });
                      } else {
                        return StoreMessage();
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
        ],
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

    await channel.bind('AllChats', (PusherEvent? event) {
      final String rawData = event!.data!;
      final String data = rawData.startsWith('[') && rawData.endsWith(']')
          ? rawData
          : '[$rawData]';

      final List<dynamic> decodedData = jsonDecode(data);

      for (final dynamic item in decodedData) {
        final Map<String, dynamic> itemData = item as Map<String, dynamic>;
        final latestMessage = LatestMessageDataModel.fromJson(itemData);
        for (int index = 0; index < latestMessagesModel.data.length; index++) {
          if (latestMessage.otherUserId ==
              latestMessagesModel.data[index].otherUserId) {
            controller.latestMessagesList.removeAt(index);
            controller.latestMessagesList.insert(
              index,
              LatestMessageCard(latestMessagesModel: latestMessage),
            );
            controller.update();
            return;
          }
        }
      }
    });
    await pusher.connect();
  }
}
