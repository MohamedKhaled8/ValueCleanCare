import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class UserHomeService {
  Future<dynamic> getUserHome() async {
    final data = await ApiService().get(
      url: EndPointName.USERHOME,
   token: loginData!.token
    );
    return data;
  }
}
