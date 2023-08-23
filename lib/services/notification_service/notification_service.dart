import 'package:vc/helper/api.dart';

import '../../helper/caching_data.dart';

class NotificationService {
  Future<dynamic> notification({required String url}) async {
    final data =
        await ApiService().get(url: url, token: loginData!.token);
    return data;
  }
}
