// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/favorites/create_favorite_model.dart';
import 'package:vc/model/favorites/delete_favorite_model.dart';
import 'package:vc/model/favorites/get_favorite_model.dart';
import 'package:vc/model/favorites/show_favorite_model.dart';
import 'package:vc/services/favorites/add_favorite_service.dart';
import 'package:vc/services/favorites/delete_favorite_service.dart';
import 'package:vc/services/favorites/get_favorite_service.dart';
import 'package:vc/services/favorites/show_favorite_service.dart';

import '../theme/constant/constants.dart';

class FavoriteController extends GetxController {
  Future<GetFavoriteModel?> getFavorite() async {
    final data = await GetFavoriteService().getFavorite(
   
    );
    if (data != null && data['statusCode'] == 200) {
      return GetFavoriteModel.fromJson(data);
    }
    return null;
  }

  addFavorite(String lang,
      {required String serviceId, required BuildContext context}) async {
    final data = await AddFavoriteService().addFavorite(
      body: {'service_id': serviceId},
    
    );
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return AddFavoriteModel.fromJson(data);
    } else {
    ShowBanner.showBanner(context: context, text: data['message']);
    }
  }

  showFavorite({required int favId, required BuildContext context}) async {
    final data = await ShowFavoriteService()
        .showFavorite( favId: favId);
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return ShowFavoriteModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
  }

  deleteFavorite({
    required String id,
    required BuildContext context,
  }) async {
    final data = await DeleteFavoriteService()
        .deleteFavorite( id: id);
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return DeleteFavoriteModel.fromJson(data);
    } else {
     ShowBanner.showBanner(context: context, text: data['message']);
    }
  }
}
