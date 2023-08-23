import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';
import 'package:vc/services/chat_service/base_chat_service.dart';

class LatestMessageService {
  Future<dynamic> latestMessage(
      {required String token, required Map<String, dynamic> body}) async {
    final data = await ApiService().post(
      url: EndPointName.LATESTMESSAGE,
      body: body,
      token: token,
    );
    return data;
  }
}

class LatestMessagesService extends BaseService {
  LatestMessagesService({required super.apiService});
  Future<dynamic> latestMessages() async {
    return get(EndPointName.latestMessages, loginData!.token);
  }
}
