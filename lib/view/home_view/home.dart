import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/services_model/user_home_model.dart';
import 'package:vc/view/home_view/appbar_home.dart';
import 'package:vc/view/home_view/offer_home_builder.dart';
import 'package:vc/view/home_view/top_service_card.dart';
import '../../animation/home_shimmer.dart';
import '../../theme/constant/sized.dart';
import '../../widgets/circle_card.dart';
import '../../widgets/cont_card.dart';
import '../../widgets/no_data_txt.dart';
import '../../widgets/search_bar.dart' as search_bar;
import '../sub_categories_view.dart/sub_sub_categories_view.dart';

class HomeScreen extends StatelessWidget {
  final bool isFavorite;

  HomeScreen({super.key, this.isFavorite = false});
  final UserHomeController homeController = UserHomeController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeController.userHome(context: context),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final UserHomeModel homeModel = snapshot.data as UserHomeModel;
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 60).r,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20).r,
                    child: Column(
                      children: [
                        AppBarHome(
                            user: true,
                            notificatioCount: homeModel.notification!,
                            userName: loginData!.userData.name,
                            userImage: loginData!.userData.photo.isEmpty
                                ? 'assets/images/png/user.png'
                                : loginData!.userData.photo,
                            screenUtil: screenUtil),
                        SizedBox(
                          height: screenUtil.setHeight(20),
                        ),
                        search_bar.SearchBar(
                          screenUtil: screenUtil,
                          shearchServiceLsit: homeModel.service,
                        ),
                        homeModel.announcement!.isNotEmpty
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16).r,
                                height: screenUtil.setHeight(155),
                                width: double.infinity,
                                child: OffersHomeBuilder(
                                  offers: homeModel.announcement,
                                ),
                              )
                            : NoDataTxt(
                                text: 'No announcement yet'.tr,
                              ),
                        SizedBox(
                          height: screenUtil.setHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Category".tr,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => SubSubCategoriesPage(
                                    homeModel: homeModel,
                                  ),
                                );
                              },
                              child: Text(
                                "See All".tr,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenUtil.setHeight(10),
                        ),
                        homeModel.subsubcategories!.isNotEmpty
                            ? ContCard(
                                shimmer: false,
                                categories: homeModel.subsubcategories!,
                                screenUtil: screenUtil,
                              )
                            : NoDataTxt(
                                text: 'No categories yet'.tr,
                              ),
                        SizedBox(
                          height: screenUtil.setHeight(15),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Our Services".tr,
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: screenUtil.setHeight(10),
                        ),
                        homeModel.service!.isNotEmpty
                            ? CircleCard(
                                serviceList: homeModel.service!,
                                screenUtil: screenUtil,
                              )
                            : NoDataTxt(
                                text: 'No Service yet'.tr,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16).r,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Top Services".tr,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  homeModel.topService!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return TopServiceCard(
                              isFavourite: isFavorite,
                              serviceModel: homeModel.service![index],
                              topServiceModel: homeModel.topService![index],
                            );
                          },
                          itemCount: homeModel.topService!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        )
                      : NoDataTxt(
                          text: 'No Top Service yet'.tr,
                        ),
                ],
              ),
            ),
            // bottomNavigationBar: BottomNavBar(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 218, 218, 218),
            highlightColor: const Color.fromARGB(255, 244, 244, 244),
            child: const HomeShimmer(),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
