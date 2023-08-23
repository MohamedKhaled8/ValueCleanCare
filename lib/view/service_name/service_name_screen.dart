// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/favorite_controller.dart';
import 'package:vc/model/jobs_done_model.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/view/home_view/home.dart';
import 'package:vc/view/service_name/review_screen.dart';
import 'package:vc/widgets/container_shadow.dart';
import 'package:vc/widgets/rating.dart';
import '../../controller/jobs_done_controller.dart';
import '../../controller/myController.dart';
import '../../model/services_model/user_home_model.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/arrow_back_icons.dart';
import 'card_detailes_view.dart';
import '../../widgets/custom_buttom_navbar.dart';

class ServiceNameScreen extends StatelessWidget {
  final Service serviceModel;
  final bool? isfavorite;

  const ServiceNameScreen({
    Key? key,
    required this.serviceModel,
    this.isfavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
    final FavoriteController favoController = FavoriteController();
    final JobsDoneController jobsDoneController = JobsDoneController();
    bool isFavorite = isfavorite ?? serviceModel.isFavorite;

    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: screenUtil.setHeight(300),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/icons/backg1.jpg"),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArrowBackIcon(
                  color: Colors.white,
                  ontap: () {
                    Get.back(
                        result: HomeScreen(
                      isFavorite: isFavorite,
                    ));
                  },
                ),
                FavoriteButton(
                  isFavorite: isFavorite,
                  iconSize: 45.h,
                  valueChanged: (value) {
                    isFavorite = value;
                    if (value) {
                      favoController.addFavorite('en',
                          context: context,
                          serviceId: serviceModel.id.toString());
                    } else {
                      favoController.deleteFavorite(
                        context: context,
                        id: serviceModel.id.toString(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 30).r,
              width: size.width,
              height: screenUtil.setHeight(800),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))
                      .r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          checkNameLength(serviceName: serviceModel.title),
                          style: TextStyle(
                              fontSize: 26.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${serviceModel.price} \$ hr",
                          style: TextStyle(
                              color: ColorApp.primary, fontSize: 20.sp),
                        )
                      ],
                    ),
                    SizedBox(height: screenUtil.setHeight(20)),
                    CustomRating(
                      textColor: Colors.black,
                      initialRating: serviceModel.rate.toDouble(),
                      serviceID: serviceModel.id,
                      size: 30,
                    ),
                    SizedBox(height: screenUtil.setHeight(30)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "About this service".tr,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: screenUtil.setHeight(10)),
                    GetBuilder<MyController>(builder: (_) {
                      return Column(
                        children: [
                          Text(
                            serviceModel.description,
                            style: TextStyle(fontSize: 18.sp),
                            maxLines: controller.isShowMore ? 4 : null,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextButton(
                              onPressed: () {
                                controller.isShowMoree();
                              },
                              child: Text(
                                controller.isShowMore
                                    ? "Read less".tr
                                    : "Read more".tr,
                                style: TextStyle(
                                    fontSize: 20.sp, color: ColorApp.primary),
                              )),
                        ],
                      );
                    }),
                    SizedBox(height: screenUtil.setHeight(10)),
                    Container(
                      height: screenUtil.setHeight(55),
                      width: screenUtil.setWidth(358),
                      decoration: buildShadowContainer(
                        borderRadius: BorderRadius.circular(20).w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10).r,
                            child: Text(
                              "Jobs done".tr,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            height: size.height,
                            width: screenUtil.setWidth(100),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20))
                                  .r,
                              color: ColorApp.primary,
                            ),
                            child: FutureBuilder(
                                future: jobsDoneController.jobsDone(
                                    context: context,
                                    id: serviceModel.id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    final JobsDoneModel jobsDoneModel =
                                        snapshot.data as JobsDoneModel;
                                    return Center(
                                      child: Text(
                                        jobsDoneModel.jobDone.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  ReviewScreen(
                                    reviewInfo: serviceModel.review!,
                                  ),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 1000),
                                );
                              },
                              child: Text(
                                "Reviews".tr,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: screenUtil.setWidth(15)),
                            Text(
                              "(${serviceModel.review!.length})",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                                () => ReviewScreen(
                                      reviewInfo: serviceModel.review!,
                                    ),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 1000));
                          },
                          child: Text(
                            "See all".tr,
                            style: TextStyle(
                                color: ColorApp.primary, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(20),
                    ),
                    SizedBox(
                      height: screenUtil.setHeight(176),
                      child: ListView.builder(
                          itemCount: serviceModel.review!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ReviewCardDetails(
                              reviewInfo: serviceModel.review![index],
                              screenUtil: screenUtil,
                              controller: controller,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: CustomButtomNavBar(
        serviceModel: serviceModel,
        screenUtil: screenUtil,
      ),
    );
  }

  dynamic setImage({required int index}) {
    if (serviceModel.images.contains('http')) {
      return NetworkImage(serviceModel.images);
    }
  }

  String checkNameLength({required String serviceName}) {
    if (serviceName.length > 15) {
      return '${serviceName.substring(0, 13)}...';
    } else {
      return serviceName;
    }
  }
}
