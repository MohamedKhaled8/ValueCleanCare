// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/controller/favorite_controller.dart';
import 'package:vc/model/favorites/get_favorite_model.dart';
import 'package:vc/model/services_model/user_home_model.dart';
import 'package:vc/model/top_service_model.dart';
import 'package:vc/theme/constant/sized.dart';
import 'package:vc/widgets/no_data_txt.dart';

import '../../widgets/default_appBar.dart';
import 'favorite_card.dart';

class FavoriteListScreen extends StatelessWidget {
  FavoriteListScreen({super.key});
  final FavoriteController favoriteController = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    UserHomeModel? homeModel;
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          ontap: () {
            Get.back();
          },
          screenUtil: screenUtil,
          text: 'Favorite List'.tr,
          size: 130,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              FutureBuilder(
                  future: favoriteController.getFavorite(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      final favoriteData = snapshot.data as GetFavoriteModel;
                      if (favoriteData.data!.isNotEmpty) {
                        return Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return FavoriteCard(
                                topServiceModel: TopServiceModelCard(
                                  title: favoriteData
                                      .data![index].service![0].title!.tr,
                                  image: favoriteData
                                      .data![index].service![0].images!,
                                  rate: favoriteData
                                      .data![index].service![0].rate!,
                                  price: favoriteData
                                      .data![index].service![0].price!,
                                  id: favoriteData.data![index].id!,
                                  is_favorite: favoriteData
                                          .data![0].service![0].isFavorite ??
                                      false,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox();
                            },
                            itemCount: favoriteData.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        );
                      } else {
                        return NoDataTxt(text: 'No Favorites Yet'.tr);
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
