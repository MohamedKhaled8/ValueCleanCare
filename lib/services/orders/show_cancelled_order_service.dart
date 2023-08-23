
import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';

class ShowCancelledOrderService {
  Future<dynamic> showCancelledOrder() async {
    final data = await ApiService().get(
      url: EndPointName.SHOWCANCELLEDORDER,
       token: loginData!.token
    );
    return data;
  }
}