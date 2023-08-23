// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/orders/add_order_model.dart';
import 'package:vc/model/orders/cancel_delete_order_mode.dart';
import 'package:vc/model/orders/finished_order_model.dart';
import 'package:vc/model/orders/show_cancel_order_model.dart';
import 'package:vc/services/orders/add_order_service.dart';
import 'package:vc/services/orders/cancelled_order_service.dart';
import 'package:vc/services/orders/finished_order.dart';
import 'package:vc/services/orders/pdf_order_service.dart';
import 'package:vc/services/orders/show_cancelled_order_service.dart';
import '../../model/orders/order_model.dart';
import '../../services/orders/get_order_service.dart';
import '../../theme/constant/constants.dart';

class OrderController extends GetxController {
  Future<OrdersModel?> getOrder({required BuildContext context}) async {
    final data = await GetOrderService().getOrder(
     
    );
    if (data != null && data['statusCode'] == 200) {
      return OrdersModel.fromJson(data);
    } else {
   ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<dynamic> pdfOrder({required String id}) async {
    final data = await PdfOrderService().pdfOrder(
      id: id,
     
    );
    return data;
  }

  Future<AddOrderModel?> addOrder({
    required BuildContext context,
    required String workArea,
    required String date,
    required String time,
    required String address,
    required String repeat,
    required String serviceId,
    required List subService,
    required List images,
    required List requirement,
    required List count,
  }) async {
    final data = await AddOrderService().addOrder(
      body: {
        'work area': workArea,
        'date': date,
        'time': time,
        'address': address,
        'repeat': repeat,
        'service_id': serviceId,
        'subService': subService,
        'gallery': images,
        'requirement': requirement,
        'count': count,
      },
      
    );
    if (data != null && data['statusCode'] == 200) {
  ShowBanner.showBanner(context: context, text:'adding order successfully1');
     
      return AddOrderModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  bool btnCancelledState = false;
  Future<CancelledOrDeletedOrderModel?> cancellOrder(
      {required BuildContext context, required int id}) async {
    final data = await CancelledOrderService()
        .cancelledOrder(id: id);
    if (data != null) {
    
      return CancelledOrDeletedOrderModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  void cancelState() {
    if (btnCancelledState) {
      btnCancelledState = false;
    } else {
      btnCancelledState = true;
    }
  }

  Future<FinishedOrderModel?> finishOrder(
      {required BuildContext context}) async {
    final data = await FinishedOrderService().finishedOrder(
   
    );
    if (data['statusCode'] == 200) {
      return FinishedOrderModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<ShowCancelledOrderModel?> showCancellOrder(
      {required BuildContext context}) async {
    final data = await ShowCancelledOrderService().showCancelledOrder(
      
    );
    if (data != null) {
  
      return ShowCancelledOrderModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }
}
