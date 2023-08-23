import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/order/order_controller.dart';
import 'package:vc/model/orders/finished_order_model.dart';

import 'package:vc/view/order_histroy/custom_orders_container.dart';
import 'package:vc/widgets/no_data_txt.dart';

import '../../theme/constant/sized.dart';

class Tab3Screen extends StatelessWidget {
  Tab3Screen({Key? key}) : super(key: key);
  final OrderController finishOrderController = OrderController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: finishOrderController.finishOrder(context: context),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final FinishedOrderModel data = snapshot.data as FinishedOrderModel;
            if (data.finishedOrder!.isNotEmpty) {
              return Container(
                margin: const EdgeInsets.only(top: 220).r,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == data.finishedOrder!.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20).r,
                          child: CustomOrdersContainer(
                            data: data.finishedOrder![index],
                          ),
                        );
                      } else {
                        return CustomOrdersContainer(
                          data: data.finishedOrder![index],
                        );
                      }

                      // ignore: avoid_types_as_parameter_names
                    },
                    // ignore: avoid_types_as_parameter_names
                    separatorBuilder: (BuildContext cont, int) {
                      return SizedBox(
                        height: screenUtil.setHeight(20),
                      );
                    },
                    itemCount: data.finishedOrder!.length),
              );
            } else {
              return NoDataTxt(text: 'No Finished Order Yet'.tr);
            }
          } else {
            return const SizedBox();
          }
        }));
  }
}
