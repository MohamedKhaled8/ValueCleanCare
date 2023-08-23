import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

class DeleteAccountService {
  Future<dynamic> deleteAccount(
      ) async {
    final data = await ApiService().delete(
      url: EndPointName.DELETEACCOUNT,
      token: loginData!.token,
    );
    return data;
  }
}
