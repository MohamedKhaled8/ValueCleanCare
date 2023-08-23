import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/company/get_company_controller.dart';
import 'package:vc/controller/user_home_controller.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/model/company/all_compaany_model.dart';
import 'package:vc/model/services_model/user_home_model.dart';
import 'package:vc/model/transport_companies_model.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/view/transport_view/transport_card_widgets.dart';
import 'package:vc/view/transport_view/transport_companies_see_all.dart';
import 'package:vc/view/home_view/appbar_home.dart';
import 'package:vc/view/home_view/offer_home_builder.dart';
import 'package:vc/widgets/cont_card.dart';
import 'package:vc/widgets/no_data_txt.dart';
import 'package:vc/widgets/search_bar.dart' as search_bar;

class TransportCompaniesScreen extends StatelessWidget {
  TransportCompaniesScreen({super.key});
  final GetCompanyController getCompanyController = GetCompanyController();

  @override
  Widget build(BuildContext context) {
    final UserHomeController homeController = Get.put(UserHomeController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                  future: homeController.userHome(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      final UserHomeModel homeData =
                          snapshot.data as UserHomeModel;
                      if (homeData.announcement!.isNotEmpty ||
                          homeData.service!.isNotEmpty) {
                        return Column(
                          children: [
                            AppBarHome(
                                notificatioCount: homeData.notification!,
                                user: false,
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
                              iconSize: 40,
                            ),
                            homeData.announcement!.isNotEmpty
                                ? Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 16)
                                            .r,
                                    height: screenUtil.setHeight(155),
                                    width: double.infinity,
                                    child: OffersHomeBuilder(
                                      offers: homeData.announcement,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(30).w,
                                    child: Text(
                                      'No announcement yet'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                            SizedBox(
                              height: screenUtil.setHeight(10),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "All Category".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            ),
                            SizedBox(
                              height: screenUtil.setHeight(10),
                            ),
                            homeData.subsubcategories!.isNotEmpty
                                ? ContCard(
                                    shimmer: false,
                                    categories: homeData.subsubcategories,
                                    screenUtil: screenUtil)
                                : Padding(
                                    padding: const EdgeInsets.all(20).w,
                                    child: Text(
                                      'No categories yet'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                            SizedBox(
                              height: screenUtil.setHeight(15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transport Companies".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => TransportCompaniesSeeAll(),
                                      transition: Transition.zoom,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                    );
                                  },
                                  child: Text(
                                    "See all".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenUtil.setHeight(10),
                            ),
                          ],
                        );
                      } else {
                        return const NoDataTxt(text: 'No Data Yet');
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
            FutureBuilder(
              future: getCompanyController.allCompany(context: context),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final AllCompanyModel companyModel =
                      snapshot.data as AllCompanyModel;

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return TransportCard(
                        transportcompaniesmodel: TransportCompaniesModel(
                            image: companyModel.data![index].photo,
                            title: companyModel.data![index].name),
                        data: companyModel.data![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: companyModel.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
