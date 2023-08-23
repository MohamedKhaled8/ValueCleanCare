import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

class CodeConfirmService {
  Future<dynamic> codeConfirm({required Map body}) async {
    final data = await ApiService().post(
      url: EndPointName.CHECKCODE,
      token: loginData!.token,
      body: body,
    );
    return data;
  }
}
