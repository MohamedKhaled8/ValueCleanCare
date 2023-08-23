import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class AddOrderService {
    Future<dynamic> addOrder({
    required Map<String, dynamic> body,
  }) async {
    final data = await ApiService().multiPartR(
      url: EndPointName.CREATEORDER,
      body: body,
       token: loginData!.token
    );
    return data;
  }
}
