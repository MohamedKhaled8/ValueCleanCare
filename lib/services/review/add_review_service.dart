import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';


class AddReviewService {
  Future<dynamic> addReview(
      {
        required String url,
        required Map<String, dynamic> body}) async {
    final data = await ApiService().post(
      url: url,
      body: body,
      token: loginData!.token,
    );
    return data;
  }
}