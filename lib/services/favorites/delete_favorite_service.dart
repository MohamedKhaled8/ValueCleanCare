import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class DeleteFavoriteService {
  Future<dynamic> deleteFavorite(
      {required String id}) async {
    final data = await ApiService().delete(
      url: EndPointName.DELETEFAVORITE + id,
       token: loginData!.token
    );
    return data;
  }
}
