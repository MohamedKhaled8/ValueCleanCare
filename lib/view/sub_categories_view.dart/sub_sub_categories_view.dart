import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/services_model/user_home_model.dart';
import '../../theme/constant/sized.dart';

class SubSubCategoriesPage extends StatelessWidget {
  const SubSubCategoriesPage({
    super.key,
    required this.homeModel,
  });
  final UserHomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenUtil.setHeight(60),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sub Sub Categories',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: homeModel.subsubcategories!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                height: screenUtil.setHeight(125),
                margin: const EdgeInsets.all(15).w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15).w,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenUtil.setHeight(110),
                      width: screenUtil.setWidth(95),
                      margin: const EdgeInsets.only(left: 7).r,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15).w,
                          color: const Color(0xffB9FFC0)),
                      child: setImage(index: index) != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15).w,
                              child: Image(
                                image: setImage(index: index),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          homeModel.subsubcategories![index].title,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  dynamic setImage({required int index}) {
    if (homeModel.subsubcategories![index].images != '' &&
        homeModel.subsubcategories![index].images.contains('http')) {
      return NetworkImage(homeModel.subsubcategories![index].images);
    }
  }
}
