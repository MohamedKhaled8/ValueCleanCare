import 'package:vc/helper/api.dart';
import 'package:vc/helper/end_points.dart';

import '../helper/caching_data.dart';

class JobsDoneService {
  Future<dynamic> jobsDone({required String id}) async {
    final data = await ApiService().get(
        url: EndPointName.JOBSDONE+id,
         token: loginData!.token
    );
    return data;
  }
}