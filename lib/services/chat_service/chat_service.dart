import '../../helper/api.dart';
import '../../helper/caching_data.dart';
import '../../helper/end_points.dart';
import 'base_chat_service.dart';

class ChatMessageService extends BaseService {
  ChatMessageService({required ApiService apiService})
      : super(apiService: apiService);

  Future<dynamic> chatMessage({
    required int id,
  }) async {
    return get(EndPointName.chatMessages + id.toString(), loginData!.token);
  }
}
