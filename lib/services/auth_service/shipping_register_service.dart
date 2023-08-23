import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

class ShippingRegisterService {
  Future<dynamic> shippingRegister({required Map<String,dynamic> body}) async {
    final data = await ApiService().post(
      url: EndPointName.shippingCompany,
      body: body,
    );
    return data;
  }
}
