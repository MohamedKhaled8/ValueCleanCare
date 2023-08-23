import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

class GetRoomMessageService {
  Future<dynamic> getRoomMessage({required String token}) async {
    final data = await ApiService().get(
      url: EndPointName.GETUSERMESSAGES,
      token: token,
    );
    return data;
  }
}
