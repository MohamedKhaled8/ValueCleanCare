// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vc/controller/service_form_controller.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';

import '../../../widgets/container_shadow.dart';

class PickDateTime extends StatefulWidget {
  final String date;
  final String time;
  const PickDateTime({
    super.key,
    this.date = 'Date',
    this.time = 'Time',
  });

  @override
  State<PickDateTime> createState() => _PickDateTimeState();
}

class _PickDateTimeState extends State<PickDateTime> {
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController timeInput = TextEditingController();

  final _serviceController = Get.put(ServiceFormController());
  @override
  void initState() {
    super.initState();
    dateInput.text = widget.date;
    timeInput.text = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: screenUtil.setHeight(40),
            width: size.width / 2,
            decoration:
                buildShadowContainer(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: dateInput,
              decoration: InputDecoration(
                hintText: 'Date '.tr,
                hintStyle:  TextStyle(
                    height: 1.5, fontSize: 14.sp, color: Colors.black),
                border: InputBorder.none,
                icon: Container(
                  // padding: EdgeInsets.only(bottom: 5),
                  height: screenUtil.setWidth(40),
                  width: screenUtil.setWidth(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    color: ColorApp.primary,
                    image: const DecorationImage(
                        image: AssetImage('assets/icons/c1.png')),
                  ),
                ),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  String formattedDate = DateFormat('yMMMd').format(pickedDate);
                  _serviceController.orderDate = formattedDate;
                  setState(() {
                    dateInput.text = formattedDate;
                  });
                }
              },
            ),
          ),
        ),
        SizedBox(
          width: screenUtil.setWidth(10),
        ),
        Expanded(
          child: Container(
            height: screenUtil.setHeight(40),
            width: size.width / 2,
            decoration:
                buildShadowContainer(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: timeInput,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "time ".tr,
                hintStyle: TextStyle(
                    fontSize: 16.sp, height: 1.5, color: Colors.black),
                icon: Container(
                  height: screenUtil.setWidth(40),
                  width: screenUtil.setWidth(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).w,
                    color: ColorApp.primary,
                    image: const DecorationImage(
                        image: AssetImage('assets/icons/c2.png')),
                  ),
                ),
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                if (pickedTime != null) {
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(parsedTime);
                  _serviceController.orderTime = formattedTime;

                  setState(() {
                    timeInput.text = formattedTime;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
