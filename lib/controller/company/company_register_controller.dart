// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/company/company_register_model.dart';
import 'package:vc/services/auth_service/shipping_register_service.dart';
import 'package:vc/services/company/company_register_service.dart';

import '../../model/auth/register_model.dart';
import '../../services/auth_service/register_service.dart';
import '../../view/auth_view/login_view.dart';

class CompanyRegisterController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();
  final TextEditingController companyId = TextEditingController();

  bool userAccount = true;
  bool companyAccount = false;
  bool shippingCompanyAccount = false;
  String groupValue = 'user';

  checkAccountType({required String selectedAccount}) {
    if (selectedAccount == 'company') {
      companyAccount = true;
      userAccount = false;
      shippingCompanyAccount = false;
      groupValue = 'company';
    } else if (selectedAccount == 'Shipping Company') {
      shippingCompanyAccount = true;
      userAccount = false;
      companyAccount = false;
      groupValue = 'Shipping Company';
    } else {
      userAccount = true;
      companyAccount = false;
      shippingCompanyAccount = false;
      groupValue = 'user';
    }
    update();
  }

  Future<void> companyRegister({
    required BuildContext context,
  }) async {
    final data = await CompanyRegisterService().companyRegister(
      body: {
        'name': name.text,
        'email': email.text,
        'address': address.text,
        'phone': phone.text,
        'password': password.text,
        'password_confirmation': passwordConfirmation.text,
        'companyId': companyId.text,
      },
    );
    if (data['statusCode'] == 200 && data['status'] == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
      companyRegisteModel= CompanyRegisterModel.fromJson(data);
        Get.off(
        LoginView(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }

  }

  Future<void> shippingCompanyRegister({
    required BuildContext context,
  }) async {
    final data = await ShippingRegisterService().shippingRegister(
      body: {
        'name': name.text,
        'email': email.text,
        'address': address.text,
        'phone': phone.text,
        'password': password.text,
        'password_confirmation': passwordConfirmation.text,
        'companyId': companyId.text,
      },
    );
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
      companyRegisteModel= CompanyRegisterModel.fromJson(data);
        Get.off(
        LoginView(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }

  Future<void> register({
    required BuildContext context,
  }) async {
    final data = await RegisterService().register(
      body: {
        'name': name.text,
        'email': email.text,
        'address[0]': address.text,
        'phone': phone.text,
        'password': password.text,
        'password_confirmation': passwordConfirmation.text,
      },
    );
    if (data['statusCode'] == 200 && data['status'] == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('email created successfully!')));
      userRegisterModel = RegisterModel.fromJson(data);
      Get.off(
        LoginView(),
        transition: Transition.leftToRight,
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }
}

RegisterModel? userRegisterModel;
CompanyRegisterModel? companyRegisteModel;
