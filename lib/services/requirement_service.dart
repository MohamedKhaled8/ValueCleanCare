import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../helper/caching_data.dart';

class RequriementService {
  Future<dynamic> requiremnt({required String id}) async {
    final data = await ApiService()
        .get(url: EndPointName.REQUIREMENT + id, token: loginData!.token);
    return data;
  }
}
