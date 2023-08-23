import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/model/orders/order_model.dart';
import 'package:vc/widgets/no_data_txt.dart';

import '../../controller/order/order_controller.dart';

import 'custom_orders_container.dart';
import '../../theme/constant/sized.dart';

class Tab1Screen extends StatelessWidget {
  Tab1Screen({Key? key}) : super(key: key);

  final OrderController getOrderController = OrderController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrderController.getOrder(context: context),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final OrdersModel data = snapshot.data as OrdersModel;
            if (data.data!.isNotEmpty) {
              return Container(
                margin: const EdgeInsets.only(top: 220).r,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == data.data!.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20).r,
                          child: CustomOrdersContainer(
                            data: data.data![index],
                          ),
                        );
                      } else {
                        return CustomOrdersContainer(
                          data: data.data![index],
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
                    itemCount: data.data!.length),
              );
            } else {
              return NoDataTxt(text: 'No Current Order Yet'.tr);
            }
          } else {
            return const SizedBox();
          }
        }));
  }
}
