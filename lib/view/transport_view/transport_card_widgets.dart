import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/myController.dart';
import 'package:vc/model/company/all_compaany_model.dart';
import 'package:vc/model/transport_companies_model.dart';
import 'package:vc/view/transport_view/service%20_name_transportr.dart';
import '../../theme/constant/sized.dart';

class TransportCard extends StatelessWidget {
  TransportCard({super.key, required this.transportcompaniesmodel, this.data});
  final TransportCompaniesModel transportcompaniesmodel;
  final Data? data;
  final controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: InkWell(
        onTap: () {
          Get.to(
            () => ServiceNameTransport(),
            transition: Transition.zoom,
            duration: const Duration(milliseconds: 1000),
          );
        },
        child: Container(
          height: screenUtil.setHeight(80),
          padding: const EdgeInsets.all(10).w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15).w,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenUtil.setHeight(110),
                width: screenUtil.setWidth(90),
                padding: const EdgeInsets.all(5).w,
                child: Image.asset(
                  transportcompaniesmodel.image!,
                ),
              ),
              SizedBox(
                width: screenUtil.setWidth(20),
              ),
              Center(
                child: Text(
                  checkNameLength(
                      companyName: transportcompaniesmodel.title ?? ''),
                  style: TextStyle(color: Colors.black, fontSize: 18.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String checkNameLength({required String companyName}) {
    if (companyName.length > 25) {
      return '${companyName.substring(0, 24)}...';
    } else {
      return companyName;
    }
  }
}
