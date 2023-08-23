import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class UpdateProfileService {
  Future<dynamic> updateProfile({
    required Map<String, dynamic> body,
  }) async {
    final data = await ApiService().multiPartR(
      url: EndPointName.UPDATEPROFILE,
      body: body,
      token: loginData!.token,
    );
    return data;
  }
}
