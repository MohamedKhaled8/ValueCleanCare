// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/auth/delete_account_controller.dart';
import 'package:vc/controller/auth/logout_controller.dart';
import 'package:vc/model/auth/profile_model.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/messages/views/latest_message_screen.dart';
import 'package:vc/view/user_profile/Terms_and_conditns.dart';
import 'package:vc/view/user_profile/faq_screen.dart';
import 'package:vc/view/user_profile/item_card.dart';
import 'package:vc/view/user_profile/profile_setting_screen.dart';
import 'package:vc/widgets/container_shadow.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileCard extends StatefulWidget {
  UserProfileCard({
    super.key,
    required this.size,
    required this.screenUtil,
    required this.data,
  });

  final Size size;
  final ScreenUtil screenUtil;
  ProfileModel? data;
  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  final LogoutController logoutController = Get.put(LogoutController());
  final DeleteAccountController deleteAccountController =
      Get.put(DeleteAccountController());

  final List<Map<String, dynamic>> _items = List.generate(
      1,
      (index) => {
            'id': index,
            'title': 'Item $index',
            'description':
                'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            'isExpanded': false
          });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: InkWell(
          onTap: () {
            Get.to(
              () => ProfileSettingScreen(
                data: widget.data!,
              ),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 1000),
            );
          },
          child: Container(
            width: widget.size.width,
            height: widget.screenUtil.setHeight(50),
            decoration:
                buildShadowContainer(borderRadius: BorderRadius.circular(10).w),
            child: Padding(
              padding: const EdgeInsets.all(8.0).w,
              child: Row(
                children: [
                  Image.asset("assets/icons/user.png"),
                  SizedBox(
                    width: widget.screenUtil.setWidth(10),
                  ),
                  Text(
                    'Profile Settings'.tr,
                    style: TextStyle(fontSize: 18.sp, color: ColorApp.grey),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.navigate_next_sharp,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(
                    width: widget.screenUtil.setWidth(10),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: widget.screenUtil.setHeight(20),
      ),
      BuildItemCard(
          image: 'assets/icons/document.png',
          text: 'Terms and conditions'.tr,
          onTap: () {
            Get.to(
              Termsandconditns(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 700),
            );
          }),
      SizedBox(
        height: widget.screenUtil.setHeight(20),
      ),
      BuildItemCard(
          image: 'assets/icons/faqs.png',
          text: 'FAQ’s'.tr,
          onTap: () {
            Get.to(
              FaqScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 700),
            );
          }),
      SizedBox(
        height: widget.screenUtil.setHeight(20),
      ),
      BuildItemCard(
        image: 'assets/icons/sign-out.png',
        text: 'Delet Account'.tr,
        onTap: () async {
          await deleteAccountController.deleteAccount(context: context);
        },
      ),
      SizedBox(
        height: widget.screenUtil.setHeight(20),
      ),
      BuildItemCard(
        image: 'assets/icons/sign-out.png',
        text: 'Log out'.tr,
        onTap: () async {
          await logoutController.logout(context: context);
        },
      ),
      SizedBox(
        height: widget.screenUtil.setHeight(20),
      ),
      Container(
        width: screenUtil.setWidth(370),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20).w,
          color: Colors.white,
        ),
        child: ExpansionPanelList(
          elevation: 3,
          expansionCallback: (index, isExpanded) {
            setState(() {
              _items[index]['isExpanded'] = !isExpanded;
            });
          },
          animationDuration: const Duration(milliseconds: 600),
          children: _items
              .map(
                (item) => ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: Colors.white,
                  headerBuilder: (_, isExpanded) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: screenUtil.setHeight(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: Row(
                        children: [
                          Image.asset('assets/icons/contactus.png'),
                          SizedBox(
                            width: screenUtil.setWidth(10),
                          ),
                          Text(
                            'Contact Us'.tr,
                            style: TextStyle(
                                fontSize: 18.sp, color: ColorApp.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      BuildItemCard(
                          image: 'assets/icons/chat.png',
                          text: 'chat with us'.tr,
                          onTap: () {
                            Get.to(
                              const LatestMessagesScreen(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 700),
                            );
                          }),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      BuildItemCard(
                          image: 'assets/icons/phonecall.png',
                          text: 'Phone call'.tr,
                          onTap: () {
                            makePhoneCall(phoneNumber: '0046735173074');
                          }),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      BuildItemCard(
                          image: 'assets/icons/website.png',
                          text: 'Website'.tr,
                          onTap: () {
                            sendMail(uri: 'http://valuclean.co/');
                          }),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      BuildItemCard(
                          image: 'assets/icons/emailicon.png',
                          text: 'E-mail address'.tr,
                          onTap: () {
                            sendMail(uri: 'mailto:Info@valuclean.co');
                          }),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                    ],
                  ),
                  isExpanded: item['isExpanded'],
                ),
              )
              .toList(),
        ),
      ),
    ]);
  }

  sendMail({required String uri}) async {
    // const uri =
    //     'mailto:test@example.org?subject=Greetings&body=Hello%20World';
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      throw 'Could not launch $uri';
    }
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
