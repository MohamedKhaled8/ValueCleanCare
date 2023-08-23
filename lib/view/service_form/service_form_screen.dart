// ignore_for_file: avoid_print

import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/service_form_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/requirement_model.dart';
import 'package:vc/model/services_model/subService_model.dart';
import 'package:vc/view/samples/samples_screen.dart';
import 'package:vc/view/service_form/extra_service_btn.dart';
import 'package:vc/view/service_form/othe_room.dart';

import 'package:vc/view/service_form/widget_date_time.dart';
import 'package:vc/widgets/container_shadow.dart';
import 'package:vc/widgets/custom_app_bar.dart';
import 'package:vc/widgets/custom_text_next_button.dart';
import 'package:vc/view/service_form/slider.dart';
import '../../model/services_model/user_home_model.dart';
import '../../theme/constant/const_colors.dart';
import 'package:flutter/material.dart';

import '../../theme/constant/sized.dart';

class ServiceFormScreen extends StatefulWidget {
  final Service? serviceModel;
  final RequriementModel requirmentModel;
  final SubServiceModel subServiceModel;
  final bool editOrder;
  final Map<String, dynamic> orderEditData;
  const ServiceFormScreen({
    Key? key,
    required this.serviceModel,
    required this.requirmentModel,
    required this.subServiceModel,
    this.editOrder = false,
    this.orderEditData = const {},
  }) : super(key: key);

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  @override
  void initState() {
    super.initState();
  }

  String? seclected;

  final ServiceFormController serviceController =
      Get.put(ServiceFormController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final Map orderData = {};
    List selectedExtraServiceList = [];
    List selectedRepeatList = [];
    _extraServiceList.clear();
    createExtraServicesList();

    final List<MultiSelectCard> repeatList = [
      MultiSelectCard(
        selected: widget.editOrder
            ? widget.orderEditData['repeat'] == 'once'
                ? true
                : false
            : false,
        value: 'Once',
        child: ExtraServiceBtn(text: 'Once'.tr),
      ),
      MultiSelectCard(
        selected: widget.editOrder
            ? widget.orderEditData['repeat'] == 'weekly'
                ? true
                : false
            : false,
        value: 'Weekly',
        label: 'Testing',
        child: ExtraServiceBtn(
          text: 'Weekly'.tr,
        ),
      ),
      MultiSelectCard(
        selected: widget.editOrder
            ? widget.orderEditData['repeat'] == 'monthly'
                ? true
                : false
            : false,
        value: 'Monthly',
        child: ExtraServiceBtn(
          text: 'Monthly'.tr,
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.85),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              image: setImage(),
              serviceName: widget.serviceModel!.title,
              rating: widget.serviceModel!.rate.toDouble(),
            ),
            GetBuilder<ServiceFormController>(
              builder: (_) {
                return Container(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, top: 10).r,
                  width: size.width,
                  height: screenUtil.setHeight(700),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ).r,
                  ),
                  child: ListView(
                    children: [
                      Text(
                        'Work area'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(10),
                      ),
                      AbsorbPointer(
                        absorbing: widget.editOrder,
                        child: SlideView(
                          workArea: widget.orderEditData.isNotEmpty
                              ? RangeValues(
                                  1.0,
                                  double.parse(
                                      widget.orderEditData['workArea']!))
                              : const RangeValues(10, 25),
                        ),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(8),
                      ),
                      Text(
                        'Date and Time'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      const PickDateTime(),
                      SizedBox(
                        height: screenUtil.setHeight(25),
                      ),
                      Text(
                        'Address'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(15),
                      ),
                      Container(
                        height: screenUtil.setHeight(55),
                        width: size.width,
                        decoration: buildShadowContainer(
                            borderRadius: BorderRadius.circular(10).w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: size.height,
                              width: screenUtil.setWidth(50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10).w,
                                color: ColorApp.primary,
                                image: const DecorationImage(
                                    image: AssetImage('assets/icons/c3.png')),
                              ),
                            ),
                            SizedBox(
                              width: screenUtil.setWidth(10),
                            ),
                            /*
                            final List<MenuData> menuData = snapshot.data!.data;
                            List<DropdownMenuItem<MenuData>> dropdownItems =
                                menuData.map((data) {
                              return DropdownMenuItem<MenuData>(
                                value: data,
                                child: Text(
                                  data.name.toString(),
                                  style: TextStyle(
                                      color: ColorApp.background,
                                      fontSize: 20.sp),
                                ),
                              );
                            }).toList();

                            */
                            GetBuilder<ServiceFormController>(
                              builder: (_) => Expanded(
                                  child: AbsorbPointer(
                                absorbing: widget.editOrder,
                                child: DropdownButton(
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    dropdownColor: Colors.white,
                                    underline: const SizedBox(),
                                    hint: Text(
                                      widget.orderEditData.isNotEmpty
                                          ? widget.orderEditData['address']!
                                          : 'Select Address'.tr,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    value: seclected,
                                    items:
                                        //loginData.userData.address.map<DropdownMenuItem<String>>((e)
                                        loginData!.userData.address
                                            .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem<String>(
                                          value: e, child: Text(e));
                                    }).toList(),
                                    onChanged: (value) {
                                      seclected = value as String?;
                                      _.update();
                                    }),
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(20),
                      ),
                      Text(
                        'Repeat'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(10),
                      ),
                      AbsorbPointer(
                        absorbing: widget.editOrder,
                        child: MultiSelectContainer(
                            singleSelectedItem: true,
                            highlightColor: ColorApp.buttonBlue,
                            splashColor: ColorApp.buttonBlue,
                            itemsDecoration: MultiSelectDecorations(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5).w,
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x33000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 8,
                                      spreadRadius: 0)
                                ],
                              ),
                              selectedDecoration: BoxDecoration(
                                  color: ColorApp.primary,
                                  borderRadius: BorderRadius.circular(5).w),
                              disabledDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5).w),
                            ),
                            items: repeatList,
                            onChange: (allSelectedItems, selectedItem) {
                              selectedRepeatList = allSelectedItems;
                            }),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(20),
                      ),
                      Text(
                        'Extra Service'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(10),
                      ),
                      _extraServiceList.isNotEmpty
                          ? AbsorbPointer(
                              absorbing: widget.editOrder,
                              child: MultiSelectContainer(
                                highlightColor: ColorApp.buttonBlue,
                                splashColor: ColorApp.buttonBlue,
                                itemsDecoration: MultiSelectDecorations(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5).w,
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0x33000000),
                                          offset: Offset(0, 0),
                                          blurRadius: 8,
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  selectedDecoration: BoxDecoration(
                                      color: ColorApp.primary,
                                      borderRadius: BorderRadius.circular(5).w),
                                  disabledDecoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5).w),
                                ),
                                items: _extraServiceList,
                                onChange: (allSelectedItems, selectedItem) {
                                  if (selectedExtraServiceList
                                      .contains(selectedItem)) {
                                    selectedExtraServiceList
                                        .remove(selectedItem);
                                    for (var element
                                        in widget.subServiceModel.data!) {
                                      if (element.id.toString() ==
                                          selectedItem) {
                                        // print(serviceController
                                        //     .extraServiceTotalPrice);
                                        serviceController
                                                .extraServiceTotalPrice -=
                                            element.price;
                                        serviceController.update();
                                      }
                                    }
                                  } else {
                                    selectedExtraServiceList.add(selectedItem);
                                    for (var element
                                        in widget.subServiceModel.data!) {
                                      if (element.id.toString() ==
                                          selectedItem) {
                                        serviceController
                                                .extraServiceTotalPrice +=
                                            element.price;
                                        serviceController.update();
                                      }
                                    }
                                  }
                                  print(selectedExtraServiceList);
                                },
                              ),
                            )
                          : Text(
                              'No Extra Services For This Service',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                      SizedBox(
                        height: screenUtil.setHeight(20),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(20),
                      ),
                      Text(
                        'Other'.tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenUtil.setHeight(10),
                      ),
                      widget.requirmentModel.data!.isNotEmpty
                          ? AbsorbPointer(
                              absorbing: widget.editOrder,
                              child: Column(
                                children: List.generate(
                                    widget.requirmentModel.data!.length,
                                    (index) {
                                  if (serviceController
                                          .requirementList.length !=
                                      widget.requirmentModel.data!.length) {
                                    if (serviceController
                                            .countRequirementList.length <
                                        widget.requirmentModel.data!.length) {
                                      serviceController.countRequirementList
                                          .add(0);
                                    }
                                    serviceController.requirementPriceList
                                        .add(0);
                                  }
                                  return BuildOtherItems(
                                    price: widget.requirmentModel.data![index]
                                        .requirementPrice,
                                    roomName:
                                        '${widget.requirmentModel.data![index].title} ',
                                    roomPrice:
                                        '(${'${widget.requirmentModel.data![0].requirementPrice}\$'})',
                                    btnNum:
                                        widget.requirmentModel.data![index].id,
                                    index: index,
                                  );
                                }),
                              ),
                            )
                          : Text(
                              'No Requirement For This Service',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                    ],
                  ),
                );
              },
            ),
            GetBuilder<ServiceFormController>(
              builder: (_) => CustomTextNextButton(
                  orderEditing: widget.editOrder,
                  totalPrice:
                      '${_.requirementTotalPrice + _.extraServiceTotalPrice + widget.serviceModel!.price}',
                  onTap: () {
                    if (!widget.editOrder) {
                      final otherService = [];

                      for (int index = 0;
                          index < widget.requirmentModel.data!.length;
                          index++) {
                        otherService
                            .add(serviceController.countRequirementList[index]);
                      }

                      if (_.orderTime.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Time Field is required!')));
                        return null;
                      }
                      if (_.orderDate.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Date Field is required!')));
                        return null;
                      }
                      if (seclected == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Address Field is required!')));
                        return null;
                      }

                      Get.to(() => SamplesScreen(
                            orderData: {
                              'workArea': _.workArea!.end.toString(),
                              'orderDate': _.orderDate,
                              'orderTime': _.orderTime,
                              'address': seclected,
                              'repeat': selectedRepeatList.isNotEmpty
                                  ? selectedRepeatList[0]
                                  : 'Once',
                              'sub_service_id': selectedExtraServiceList,
                              'totalPrice':
                                  '${_.requirementTotalPrice + _.extraServiceTotalPrice + widget.serviceModel!.price}',
                              'requirement': serviceController.requirementList,
                              'count': otherService,
                            },
                            serviceModel: widget.serviceModel!,
                          ));
                    } else {}
                  }),
            ),
          ],
        ),
      ),
    );
  }

  dynamic setImage() {
    if (widget.serviceModel != null &&
        widget.serviceModel!.images.contains('http')) {
      return NetworkImage(widget.serviceModel!.images);
    } else {
      return const AssetImage('assets/icons/cleaning 1.png');
    }
  }

  createExtraServicesList() {
    var subServices = [];
    if (widget.editOrder) {
      subServices = widget.orderEditData['Extra']!;
    } else {
      subServices = widget.subServiceModel.data ?? [];
    }
    for (int index = 0; index < subServices.length; index++) {
      _extraServiceList.add(
        MultiSelectCard(
          value: widget.editOrder
              ? index
              : widget.subServiceModel.data![index].id.toString(),
          child: ExtraServiceBtn(
            text:
                '${subServices[index].title} (${subServices[index].price} \$)',
          ),
        ),
      );
    }
  }

  final List<MultiSelectCard> _extraServiceList = [];
}
