import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';

class CheckoutPaymentService {
  Future<dynamic> checkoutPayment({required Map<String, dynamic> body}) async {
    final data =
        await ApiService().post(url: EndPointName.CHECKOUTPAYMENT, body: body,token: loginData!.token);

    return data;
  }
}
