import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vc/controller/favorite_controller.dart';
import 'package:vc/model/top_service_model.dart';
import 'package:vc/theme/constant/const_colors.dart';
import 'package:vc/widgets/rating.dart';

import '../../controller/myController.dart';
import '../../theme/constant/sized.dart';

class FavoriteCard extends StatelessWidget {
  final TopServiceModelCard topServiceModel;
  final bool? isFavourite;
  final double width;
  FavoriteCard({
    super.key,
    required this.topServiceModel,
    this.isFavourite,
    this.width = 95,
  });

  final controller = Get.put(MyController());
  final FavoriteController _favoController = FavoriteController();

  @override
  Widget build(BuildContext context) {
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screenUtil.setHeight(110),
            width: screenUtil.setWidth(width),
            margin: const EdgeInsets.only(left: 7).r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15).w,
                color: const Color(0xffB9FFC0)),
            child: setImage() != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15).w,
                    child: Image(
                      image: setImage(),
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(),
          ),
          SizedBox(
            width: screenUtil.setWidth(20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                checkNameLength(serviceName: topServiceModel.title),
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10).r,
                child: Text(
                  "${topServiceModel.price}  / hr",
                  style: TextStyle(color: ColorApp.primary, fontSize: 16.sp),
                ),
              ),
              CustomRating(
                textColor: Colors.black,
                initialRating: topServiceModel.rate.toDouble(),
                serviceID: topServiceModel.id,
                size: 25,
              ),
            ],
          ),
          GetBuilder<MyController>(builder: (controller) {
            return Expanded(
              child: FavoriteButton(
                isFavorite: topServiceModel.is_favorite,
                iconSize: 40.sp,
                valueChanged: (value) {
                  if (value) {
                    _favoController.addFavorite('en',
                        context: context,
                        serviceId: topServiceModel.id.toString());
                  } else {
                    _favoController.deleteFavorite(
                      context: context,
                      id: topServiceModel.id.toString(),
                    );
                  }
                },
              ),
            );
          })
        ],
      ),
    );
  }

  dynamic setImage({int? index}) {
    if (topServiceModel.image.contains('http')) {
      return NetworkImage(topServiceModel.image);
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
