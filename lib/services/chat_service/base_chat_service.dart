import 'package:vc/helper/api.dart';

abstract class BaseService {
  final ApiService apiService;

  BaseService({required this.apiService});

  Future<dynamic> get(String url, String token) async {
    return apiService.get(url: url, token: token);
  }

  Future<dynamic> post(String url, Map<String,dynamic> body, String token) async {
    return apiService.post(url: url, body: body, token: token);
  }
  Future<dynamic> multiPartRequest(String url, Map<String,dynamic> body, String token) async {
    return apiService.multiPartR(url: url, body: body, token: token);
  }

  Future<dynamic> patch(String url,  Map<String,dynamic> body, String token) async {
    return apiService.patch(url: url, body: body, token: token);
  }

  Future<dynamic> delete(String url, String token) async {
    return apiService.delete(url: url, token: token);
  }
}
