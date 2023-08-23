import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class LogoutService {
  Future<dynamic> logout() async {
    final data = await ApiService().get(
      url: EndPointName.LOGOUT,
        token: loginData!.token,
    );
    return data;
  }
}
