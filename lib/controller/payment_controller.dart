// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/payment/all_payment_mdel.dart';
import 'package:vc/model/payment/checkout_payment_model.dart';
import 'package:vc/services/payment/add_payment_card.dart';
import 'package:vc/services/payment/checkout_payment_service.dart';
import 'package:vc/services/payment/get_all_payment_service.dart';
import '../model/payment/add_card_model.dart';
import '../theme/constant/constants.dart';

class PaymentController extends GetxController {
  bool credit = true;
  bool recepit = false;
  bool cvvTextFiledisFouce = false;

  selectPatmentType({required String type}) {
    if (type == 'credit'.tr) {
      credit = true;
      recepit = false;
    } else if (type == 'recepit'.tr) {
      credit = false;
      recepit = true;
    }
    update();
  }

  updateUi() {
    update();
  }

  AllPaymentModel? allPaymentModel;
  Future<AddPaymentCardModel?> addPaymentCard({
    required BuildContext context,
    required String number,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    final data = await AddPaymentCardService().addPaymentCard(
      body: {
        'number': number,
        'exp_month': expMonth,
        'exp_year': expYear,
        'cvc': cvc,
      },
    );
    if (data['statusCode'] == 200) {
     ShowBanner.showBanner(context: context, text: data['message']);
      return AddPaymentCardModel.fromJson(data);
    } else {
ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<CheckoutPaymentModel?> checkOutPayment({
    required BuildContext context,
    required String orderId,
    required String amount,
    required String customerId,
  }) async {
    final data = await CheckoutPaymentService().checkoutPayment(body: {
      'order_id': orderId,
      'amount': amount,
      'token': loginData!.token,
      'customer_id': customerId,
    });
    if (data['statusCode'] == 200) {
    ShowBanner.showBanner(context: context, text: data['message']);
      return CheckoutPaymentModel.fromJson(data);
    } else {
    ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<AllPaymentModel?> allPayment() async {
    final data =
        await GetAllPaymentService().getAllPayment();
    if (data['statusCode'] == 200) {
      return AllPaymentModel.fromJson(data);
    }
    return null;
  }
}
