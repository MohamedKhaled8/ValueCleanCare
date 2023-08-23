// ignore_for_file: depend_on_referenced_packages, empty_catches, duplicate_ignore, avoid_print
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
 Future<dynamic> get({
    required String url,
    bool file = false,
    String? token,
  }) async {
    http.Response? data;
    try {
      data = await http.get(
        Uri.parse(url),
        headers: file
            ? {
                'Authorization': 'Bearer $token',
                'Accept': 'application/pdf',
              }
            : {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
      );
      if (data.contentLength! > 0 && data.statusCode == 200 ||
          data.statusCode == 201) {
        if (file) {
          return data.bodyBytes;
        } else {
          return json.decode(data.body);
        }
      } else {
        return {
          'error': 'Api Format Error',
          'body': data.body,
          'statusCode': '${data.statusCode}',
          'message': data.body.isEmpty
              ? "No Content Error"
              : jsonDecode(data.body)['message'] ?? 'Try again',
        };
      }
    } catch (e) {}
  }


  Future<dynamic> post({
    required String url,
    required dynamic body,
    bool file = false,
    String? token,
  }) async {
    http.Response? data;
    try {
      data = await http.post(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          body: body);

      if (data.statusCode == 200 ||
          data.statusCode == 201 ||
          jsonDecode(data.body)['code'] != null) {
        if (file) {
          return data.body;
        } else {
          return json.decode(data.body);
        }
      } else {
        return {
          'error': 'Api Format Error',
          'body': 'Null Body',
          'statusCode': '${data.statusCode}',
          'message': jsonDecode(data.body)['message'] ?? 'Try again',
        };
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<dynamic> delete({
    required String url,
    Map<String, String>? headers,
    required String token,
  }) async {
    // debugPrint('url: $url  $token');

    http.Response? data;
    try {
      data = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'multipart/form-data',
        },
      );
      // debugPrint('${data.statusCode} data: ${data.body}');
      if (data.statusCode == 200 || data.statusCode == 201) {
        return json.decode(data.body);
      } else {
        return {
          'error': 'Api Format Error',
          'body': 'Null Body',
          'statusCode': '${data.statusCode}',
          'message': jsonDecode(data.body)['message'] ?? 'Try again',
        };
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<dynamic> multiPartR({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    // debugPrint('url: $url $body  $token');

    List valueList = [];
    bool listField = false;
    var request = http.MultipartRequest('POST', Uri.parse(url));

    try {
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'multipart/form-data',
      });

      body.forEach((key, value) async {
        if (value.runtimeType == List<dynamic>) {
          valueList = value;
          listField = true;
        } else if (value.runtimeType == List<String>) {
          valueList = value;
          listField = true;
        } else if (value.runtimeType == List<int>) {
          valueList = value;
          listField = true;
        } else {
          listField = false;
        }

        if (valueList.isNotEmpty && listField) {
          for (int index = 0; index < valueList.length; index++) {
            if (
                    GetUtils.isImage(valueList[index].toString()) ||
                value.toString().toLowerCase().endsWith(".m4a") ||
                GetUtils.isAudio(valueList[index].toString())) {
              request.files.add(await http.MultipartFile.fromPath(
                  '$key[${index.toString()}]', valueList[index].toString()));
            } else {
              request.fields
                  .addAll({'$key[${index.toString()}]': valueList[index].toString()});
            }
          }
        } else {
          if (!listField) {
            if ( GetUtils.isImage(value.toString()) ||
                GetUtils.isAudio(value.toString()) ||
                value.toString().toLowerCase().endsWith(".m4a")) {
              request.files.add(await http.MultipartFile.fromPath(key, value));
            } else {
              if (value.toString().isNotEmpty) {
                request.fields[key] = value;
              }
            }
          }
        }
      });

      var response = await request.send();

      final data = await http.Response.fromStream(response);
      // debugPrint('${data.statusCode} data: ${data.body}');
      if (data.statusCode == 200 ||
          data.statusCode == 201 ||
          jsonDecode(data.body)['code'] != null) {
        return json.decode(data.body);
      } else {
        return {
          'error': 'Api Format Error',
          'body': 'Null Body',
          'statusCode': '${data.statusCode}',
          'message': jsonDecode(data.body)['message'] ?? 'Try again',
        };
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<dynamic> patch({
    required String url,
    Map<String, String>? headers,
    required String token,
    Map<String, dynamic>? body,
  }) async {
    http.Response? data;
    try {
      data = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (data.statusCode == 200 ||
          data.statusCode == 201 ||
          jsonDecode(data.body)['code'] != null && data.body.isNotEmpty) {
        return json.decode(data.body);
      } else {
        return {
          'error': 'Api Format Error',
          'body': 'Null Body',
          'statusCode': '${data.statusCode}',
          'message': jsonDecode(data.body)['message'] ?? 'Try again',
        };
      }
    } catch (e) {
      print(e);
    }
  }
}