import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

class ForgetPasswordService {
  Future<dynamic> forgetPassword({
    required Map body,
  }) async {
    final data = await ApiService().post(
      url: EndPointName.FORGETPASSWORD,
      body: body,
      token: loginData!.token,
    );
    return data;
  }
}
