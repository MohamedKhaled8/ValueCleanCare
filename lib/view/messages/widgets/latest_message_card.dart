import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../model/chat/latest_message_model.dart';
import '../../../theme/constant/const_colors.dart';
import '../../../theme/constant/sized.dart';
import '../../../utils/binding/check_lenght_name.dart';

class LatestMessageCard extends StatelessWidget {
  final LatestMessageDataModel latestMessagesModel;
  const LatestMessageCard({super.key, required this.latestMessagesModel});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(latestMessagesModel.createdAt).toLocal();
    String customFormattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20).r,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45.h,
            backgroundImage: NetworkImage(latestMessagesModel.avatar),
          ),
          SizedBox(
            width: screenUtil.setWidth(15),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        checkNameLength(
                          productName: latestMessagesModel.name,
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 19.sp),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        customFormattedDateTime,
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenUtil.setHeight(5),
                ),
                Row(
                  children: [
                    latestMessagesModel.messageBody.isEmpty
                        ? Expanded(
                            child: Text(
                              'attachment',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  latestMessagesModel.unseenMessagesCount == 0
                                      ? TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.sp,
                                        )
                                      : TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                            ),
                          )
                        : Expanded(
                            child: Text(
                              latestMessagesModel.messageBody,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  latestMessagesModel.unseenMessagesCount == 0
                                      ? TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.sp,
                                        )
                                      : TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                        ),
                            ),
                          ),
                    const Spacer(),
                    latestMessagesModel.unseenMessagesCount == 0
                        ? const SizedBox()
                        : CircleAvatar(
                            backgroundColor: ColorApp.primary,
                            radius: 15.sp,
                            child: Text(
                              latestMessagesModel.unseenMessagesCount
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
