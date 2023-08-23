import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';

class DeleteNotificationService {
  Future<dynamic> deleteNotification(
      {required String id}) async {
    final data = await ApiService().delete(url: EndPointName.DELETENOTIFICATION+id,  token: loginData!.token);
    return data;
  }
}
