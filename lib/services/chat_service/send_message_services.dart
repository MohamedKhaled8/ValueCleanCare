import 'package:vc/helper/end_points.dart';

import '../../helper/caching_data.dart';
import 'base_chat_service.dart';

class SendMessagesService extends BaseService {
  SendMessagesService({required super.apiService});
  Future<dynamic> sendMessages(
      {required Map<String, dynamic> body}) async {
    return multiPartRequest(EndPointName.sendMessages, body, loginData!.token);
  }
}
