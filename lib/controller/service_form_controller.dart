import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceFormController extends GetxController {
  RangeValues? workArea;
  String orderDate = '';
  String orderTime = '';

  double extraServiceTotalPrice = 0;

  List<int> requirementList = [];
  List<int> countRequirementList = [];
  List<int> requirementPriceList = [];

  int requirementTotalPrice = 0;

  roomPlus({required int btnNum, required int index, required int price}) {
    if (!requirementList.contains(btnNum)) {
      requirementList.add(btnNum);
    }
    countRequirementList[index]++;
    requirementPriceList[index] = countRequirementList[index] * price;
    requirementTotalPrice = 0;
    for (var element in requirementPriceList) {
      requirementTotalPrice += element;
    }
    update();
  }

  roomMinus({required int btnNum, required int index, required int price}) {
    countRequirementList[index]--;
    if (countRequirementList[index] <= 0) {
      requirementList.remove(btnNum);
    }
    requirementPriceList[index] -= price;
    requirementTotalPrice = 0;
    for (var element in requirementPriceList) {
      requirementTotalPrice += element;
    }
    update();
  }
}
