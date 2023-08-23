// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
// import 'package:vc/model/orders/order_model.dart';

import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/view/payment/checkout_view/pdf_view.dart';
import 'package:vc/widgets/cutom_buttom_two.dart';

class OrderDetailesBottomNavigationBar extends StatelessWidget {
  final String orderId;
  const OrderDetailesBottomNavigationBar({
    Key? key,
    required this.screenUtil,
    required this.txt,
    required this.orderId,
  }) : super(key: key);

  final ScreenUtil screenUtil;
  final String txt;
  ///////////
  // final OrdersModel ordersModel;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final OrderController controller = OrderController();
    return Container(
      height: screenUtil.setHeight(60),
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).w,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 3),
              spreadRadius: 3,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5).r,
        child: CustomButtonTWo(
          screenUtil: screenUtil,
          color: ColorApp.primary,
          color1: Colors.white,
          txt: txt,
          onTap: () async {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: const Text('Downloading...'),
                actions: const [SizedBox()],
                backgroundColor: ColorApp.payment,
              ),
            );

            final pdf = await controller.pdfOrder(id: orderId);

            print(pdf.runtimeType);

            final f =
                File('/storage/emulated/0/Download/OrderPDF_$orderId.pdf');

            f.writeAsBytes(pdf);

            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: const Text('File Downloaded'),
                actions: const [SizedBox()],
                backgroundColor: ColorApp.payment,
              ),
            );

            await Future.delayed(const Duration(seconds: 2));

            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

            Get.to(() => PdfViwer(
                  filePath:
                      '/storage/emulated/0/Download/OrderPDF_$orderId.pdf',
                ));
          },
        ),
      ),
    );
  }
}
