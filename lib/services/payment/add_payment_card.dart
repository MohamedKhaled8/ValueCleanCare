import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class AddPaymentCardService {
  Future<dynamic> addPaymentCard({required Map<String, dynamic> body}) async {
    final data = await ApiService().post(
        url: EndPointName.ADDPAYMENTCARD, body: body, token: loginData!.token);
    return data;
  }
}
