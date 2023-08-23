import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/chat/chat_controller.dart';
import 'package:vc/widgets/custom_textform_field.dart';
import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import '../../../widgets/cutom_buttom_two.dart';
import '../views/latest_message_screen.dart';

class StoreMessage extends StatelessWidget {
  StoreMessage({super.key});
  final ChatController sendMessagesController = Get.put(ChatController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 30).r,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenUtil.setHeight(30)),
                    CustomTextFormField(
                      text: 'type a message...'.tr,
                      type: TextInputType.name,
                      controller: sendMessagesController.message,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'required'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: screenUtil.setHeight(30)),
                    // CustomTextFormField(

                    //   text: 'Id'.tr,
                    //   type: TextInputType.number,
                    //   controller: sendMessagesController.userId,
                    //   validate: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'required'.tr;
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
        child: CustomButtonTWo(
          color1: Colors.white,
          screenUtil: screenUtil,
          txt: 'Send Message'.tr,
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await sendMessagesController.sendMessages(
                  context: context,
                  messages: sendMessagesController.message.text,
                  media: '');
              sendMessagesController.update();
              Get.to(const LatestMessagesScreen());
            }
          },
          color: ColorApp.primary,
        ),
      ),
    );
  }
}
