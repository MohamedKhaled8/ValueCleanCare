import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';
import 'base_chat_service.dart';

class SeenMessagesService extends BaseService {
  SeenMessagesService({required ApiService apiService})
      : super(apiService: apiService);

  Future<dynamic> seenMessages({
    required Map<String, dynamic> body,
  }) async {
    return patch(EndPointName.seenMessages, body, loginData!.token);
  }
}
