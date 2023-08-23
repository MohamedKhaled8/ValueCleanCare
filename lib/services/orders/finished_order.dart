
import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';

class FinishedOrderService {
  Future<dynamic> finishedOrder() async {
    final data = await ApiService().get(
      url: EndPointName.FINISHEDDORDER,
       token: loginData!.token
    );
    return data;
  }
}