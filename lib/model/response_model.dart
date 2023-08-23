import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable{
   final String message;
  final String type;
  final int code;
  

  const ResponseModel(
      {required this.message,
      required this.type,
      required this.code,
     });
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        message: json['message'],
        type: json['type'],
        code: json['code'],
        );
  }

  @override
  List<Object?> get props => [message, type, code];

}