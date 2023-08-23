import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class GetFavoriteService {
  Future<dynamic> getFavorite() async {
    final data = await ApiService().get(
      url: EndPointName.FAVORITE,
       token: loginData!.token
    );
    return data;
  }
}
