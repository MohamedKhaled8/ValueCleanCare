// ignore_for_file: file_names

import 'package:vc/helper/api.dart';
import 'package:vc/helper/caching_data.dart';
import 'package:vc/helper/end_points.dart';

class SubService {
  Future<dynamic> subService({
    required String id,
  }) async {
    final data = await ApiService().get(
      url: EndPointName.SUBSERVICE + id,
      token: loginData!.token,
    );
    return data;
  }
}
