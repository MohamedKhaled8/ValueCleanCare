import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class ProfileService {
  Future<dynamic> profile() async {
    final data = await ApiService().get(
      url: EndPointName.PROFILE,
      token: loginData!.token
    );
    return data;
  }
}
