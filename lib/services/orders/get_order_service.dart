
import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';

class GetOrderService {
  Future<dynamic> getOrder() async {
    final data = await ApiService().get(
      url: EndPointName.ORDER,
       token: loginData!.token
    );
    return data;
  }
}