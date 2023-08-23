import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

class GetVideoCallToken {
  Future<dynamic> getVideoCallToken(
      {required Map<String, dynamic> body, required String token}) async {
    final data = await ApiService().post(
      url: EndPointName.VIDEOCALL,
      token: token,
      body: body,
    );
    return data;
  }
}
