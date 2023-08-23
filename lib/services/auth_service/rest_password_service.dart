import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

class RestPasswordService {
  Future<dynamic> restPassword({
    required Map body,
  }) async {
    final data = await ApiService().post(
      url: EndPointName.RESTPASSWORD,
      body: body,
      token: loginData!.token
    );
    return data;
  }
}
