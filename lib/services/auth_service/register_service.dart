import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

class RegisterService {
  Future<dynamic> register({required Map<String,dynamic> body}) async {
    final data = await ApiService().post(
      url: EndPointName.REGISTER,
      body: body,
    );
    return data;
  }
}
