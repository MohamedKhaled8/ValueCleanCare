import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';
import 'package:vc/services/chat_service/base_chat_service.dart';

class DeleteMessageService extends BaseService {
  DeleteMessageService({required super.apiService});
  Future<dynamic> deleteMessage(
      {required int id}) async {
    return delete(EndPointName.deleteMessages+id.toString(), loginData!.token);
  }
}
