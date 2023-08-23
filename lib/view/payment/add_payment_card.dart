// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/animation/loder.dart';
import 'package:vc/controller/payment_controller.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/theme/constant/sized.dart';
import '../../controller/animation_controller.dart';
import '../../widgets/cutom_buttom_two.dart';
import '../../widgets/default_appBar.dart';

class AddPaymentCard extends StatelessWidget {
  AddPaymentCard({Key? key}) : super(key: key);
  final TextEditingController number = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController cv = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<FormFieldState<String>>? cardNumberKey;
  GlobalKey<FormFieldState<String>>? cvvCodeKey;
  GlobalKey<FormFieldState<String>>? expiryDateKey;
  GlobalKey<FormFieldState<String>>? cardHolderKey;

  final PaymentController _addPayment = Get.put(PaymentController());
  final Animation_Controller _controller = Get.put(Animation_Controller());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          screenUtil: screenUtil,
          text: 'Add Card'.tr,
          ontap: () {
            Get.back();
          },
          size: 130,
        ),
        body: Form(
          child: GetBuilder<Animation_Controller>(
            builder: (_) => Loder(
              loder: _controller.loderShow,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<PaymentController>(
                      builder: (_) => CreditCardWidget(
                        cardNumber: number.text,
                        expiryDate: date.text,
                        cardHolderName: name.text,
                        cvvCode: cv.text,
                        showBackView: _addPayment.cvvTextFiledisFouce,
                        backgroundImage: 'assets/images/card_bg.png',
                        onCreditCardWidgetChange:
                            (value) {}, //true when you want to show cvv(back) view
                        glassmorphismConfig: Glassmorphism(
                            blurX: 2,
                            blurY: 2,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: <Color>[
                                  Colors.grey.withAlpha(20),
                                  Colors.grey.withAlpha(20),
                                ])),
                      ),
                    ),
                    CreditCardForm(
                      formKey: formKey, // Required
                      cardHolderName: name.text,
                      cardNumber: number.text,
                      cvvCode: cv.text,
                      expiryDate: date.text,
                      onCreditCardModelChange: (CreditCardModel data) {
                        number.text = data.cardNumber;
                        date.text = data.expiryDate;
                        name.text = data.cardHolderName;
                        cv.text = data.cvvCode;
                        _addPayment.cvvTextFiledisFouce = data.isCvvFocused;
                        _addPayment.updateUi();
                      }, // Required
                      themeColor: Colors.red,
                      obscureCvv: true,
                      obscureNumber: false,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      enableCvv: true,
                      cardNumberValidator: (String? cardNumber) {
                        return null;
                      },
                      expiryDateValidator: (String? expiryDate) {
                        return null;
                      },
                      cvvValidator: (String? cvv) {
                        return null;
                      },
                      cardHolderValidator: (String? cardHolderName) {
                        return null;
                      },
                      onFormComplete: () {
                        // callback to execute at the end of filling card data
                      },
                      cardNumberDecoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Number'.tr,
                        labelStyle: TextStyle(fontSize: 16.sp),
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: TextStyle(fontSize: 16.sp),
                      ),
                      expiryDateDecoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Expired Date'.tr,
                        labelStyle: TextStyle(fontSize: 16.sp),
                        hintText: 'XX/XX'.tr,
                        hintStyle: TextStyle(fontSize: 16.sp),
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'CVV'.tr,
                        labelStyle: TextStyle(fontSize: 16.sp),
                        hintText: 'XXX'.tr,
                        hintStyle: TextStyle(fontSize: 16.sp),
                      ),
                      cardHolderDecoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Card Holder'.tr,
                        labelStyle: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
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
              txt: 'Add Card'.tr,
              onTap: () async {
                try {
                  _controller.loder();
                  // print('Month => ${date.text.substring(0, 2)}');
                  // print('Year => ${date.text.substring(3, 5)}');
                  if (formKey.currentState!.validate()) {
                    await _addPayment.addPaymentCard(
                      context: context,
                      number: number.text.replaceAll(' ', ''),
                      expMonth: date.text.substring(0, 2),
                      expYear: '20${date.text.substring(3, 5)}',
                      cvc: cv.text,
                    );
                  }
                } finally {
                  _controller.loder();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
