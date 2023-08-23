import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class ShowFavoriteService {
  Future<dynamic> showFavorite({required int favId}) async {
    final data = await ApiService().get(
      url: '${EndPointName.SHOWFAVORITE}$favId',
      token: loginData!.token
    );
    return data;
  }
}
