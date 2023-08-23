// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:vc/controller/chat/chat_controller.dart';
import 'package:vc/view/messages/widgets/text_chat_bubble.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';
import '../../../model/chat/latest_message_model.dart';
import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import 'audio_chat_bubble.dart';
import 'chat_tff.dart';
import 'image_chat_bubble.dart';

class ChatBottomBar extends StatelessWidget {
  final LatestMessageDataModel dataModel;
  ChatBottomBar({super.key, required this.dataModel});
  final ChatController controller = Get.put(ChatController());
  // final ChatMessagesController chatMessagesController = Get.find();

  @override
  Widget build(context) {
    return GetBuilder<ChatController>(builder: (_) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            controller.messageTextController.text.isNotEmpty
                ? InkWell(
                    onTap: () async {
                      await controller.sendMessages(
                          context: context,
                          messages: controller.messageTextController.text,
                          media: '');
                      controller.chatMessagesList.add(TextChatBubble(
                          message: controller.messageTextController.text,
                          sender: dataModel.fromLoggedUser));

                      controller.messageTextController.clear();
                      controller.update();
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 9, left: 8, right: 12).r,
                      alignment: Alignment.center,
                      width: screenUtil.setWidth(40),
                      height: screenUtil.setHeight(40),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/icons/send.png"),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: Container(
                      clipBehavior: Clip.none,
                      margin:
                          const EdgeInsets.only(top: 15, left: 8, right: 20).r,
                      // alignment: Alignment.centerRight,
                      child: SocialMediaRecorder(
                        recordIconWhenLockBackGroundColor: ColorApp.primary,
                        cancelTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        recordIcon: Container(
                          width: screenUtil.setWidth(60),
                          height: screenUtil.setHeight(60),
                          decoration: BoxDecoration(
                            color: ColorApp.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                        recordIconBackGroundColor: ColorApp.primary,
                        sendRequestFunction: (soundFile) async {
                          // final player = AudioPlayer();
                          // await player.setUrl(soundFile.path);
                          if (soundFile.path.isNotEmpty) {
                            await controller.sendMessages(
                                context: context,
                                messages: '',
                                media: soundFile.path);
                            controller.chatMessagesList.add(AudioChatBubble(
                              audio: soundFile.path,
                              sender: dataModel.fromLoggedUser,
                            ));
                            controller.update();
                          }
                        },
                        encode: AudioEncoderType.AAC,
                      ),
                    ),
                  ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Expanded(
                flex: 1,
                child: ChatTff(
                  onChange: (value) {
                    controller.update();
                  },
                  textController: controller.messageTextController,
                  hintText: 'type a message...'.tr,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final List<File> file =
                    await Get.to(() => const WhatsappCamera());
                if (file.isNotEmpty) {
                  await controller.sendMessages(
                      context: context, messages: '', media: file.first.path);
                  controller.chatMessagesList.add(ImageChatBubble(
                    image: file.first.path,
                    sender: dataModel.fromLoggedUser,
                    id: dataModel.otherUserId.toString(),
                  ));
                  controller.update();
                  controller.update();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(5).w,
                margin: const EdgeInsets.only(left: 15, right: 5).r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: ColorApp.primary,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: ColorApp.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
