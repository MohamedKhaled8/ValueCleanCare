import 'package:equatable/equatable.dart';

class DeleteMessageModel extends Equatable{
   final String message;
   final String data;
  final String type;
  final int code;
  

  const DeleteMessageModel(
      {required this.message,
      required this.type,
      required this.code,
      required this.data,
     });
  factory DeleteMessageModel.fromJson(Map<String, dynamic> json) {
    return DeleteMessageModel(
        message: json['message'],
        data: json['data'],
        type: json['type'],
        code: json['code'],
        );
  }

  @override
  List<Object?> get props => [message, type, code,data];

}