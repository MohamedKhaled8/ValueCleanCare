import 'package:vc/helper/end_points.dart';

import '../../helper/api.dart';
import '../../helper/caching_data.dart';

class PdfOrderService {
  Future<dynamic> pdfOrder({ required String id}) async {
    final data = await ApiService().get(
      url: EndPointName.PDFORDER + id,
       token: loginData!.token,
      file: true,
    );
    return data;
  }
}
