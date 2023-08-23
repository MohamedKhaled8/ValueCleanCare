
import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';

class CancelledOrderService {
  Future<dynamic>cancelledOrder({int? id}) async {
    final data = await ApiService().get(
      url: '${EndPointName.CANCELEDORDER}$id',
       token: loginData!.token
    );
    return data;
  }
}