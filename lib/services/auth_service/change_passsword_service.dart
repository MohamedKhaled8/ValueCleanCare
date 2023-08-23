import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class ChangePasswordService {
  Future<dynamic> changePassword({
    required Map body,
  }) async {
    final data = await ApiService().post(
      url: EndPointName.CHANGEPASSWORD,
      body: body,
      token: loginData!.token,
    );
    return data;
  }
}
