import '../widgets/cont_card.dart';
import 'package:flutter/material.dart';
import '../view/home_view/appbar_home.dart';
import 'package:valueclean/widgets/action_card.dart';
import 'package:valueclean/widgets/circle_card.dart';
import 'package:valueclean/theme/constant/sized.dart';
import 'package:valueclean/model/top_service_model.dart';
import 'package:vc/widgets/search_bar.dart' as search_bar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valueclean/model/services_model/user_home_model.dart';








class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                children: [
                  AppBarHome(
                      notificatioCount: 0,
                      user: true,
                      userName: 'Loading...',
                      userImage: 'assets/images/jpeg/mohamed.jpeg',
                      screenUtil: screenUtil),
                  SizedBox(
                    height: screenUtil.setHeight(20),
                  ),
                  search_bar.SearchBar(
                    screenUtil: screenUtil,
                    shearchServiceLsit: const [],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: screenUtil.setHeight(155),
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  //////////////////
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "All Category",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  ContCard(
                      shimmer: true,
                      categories: List.generate(
                          5,
                          (index) => Subcategory(
                              id: 1, images: '', title: '', subCategory: [])),
                      screenUtil: screenUtil),
                  SizedBox(
                    height: screenUtil.setHeight(15),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Our Services",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: screenUtil.setHeight(10),
                  ),
                  CircleCard(
                      serviceList: List.generate(
                        7,
                        (index) => Service(
                            title: '',
                            images: 'assets/images/png/service.png',
                            active: 1,
                            category: '',
                            createdAt: '',
                            description: '',
                            id: 5,
                            isFavorite: true,
                            price: 1000,
                            rate: 4,
                            review: [],
                            updatedAt: '',
                            workers: []),
                      ),
                      screenUtil: screenUtil),
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
                  "Top Services",
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
            ListView.separated(
              itemBuilder: (context, index) {
                return ActionCard(
                    serviceModel: Service(
                        title: '',
                        images: 'assets/images/png/service.png',
                        active: 1,
                        category: '',
                        createdAt: '',
                        description: '',
                        id: 5,
                        isFavorite: true,
                        price: 1000,
                        rate: 4,
                        review: [],
                        updatedAt: '',
                        workers: []),
                    topServiceModel: TopServiceModelCard(
                        title: '',
                        image: '',
                        rate: 4,
                        price: 10,
                        id: 1,
                        is_favorite: false));
              },
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
