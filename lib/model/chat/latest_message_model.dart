import 'package:equatable/equatable.dart';

class LatestMessagesModel extends Equatable {
  final List<LatestMessageDataModel> data;
  final String message;
  final int code;
  final String type;

  const LatestMessagesModel({
    required this.data,
    required this.message,
    required this.code,
    required this.type,
  });
  factory LatestMessagesModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataJson = json['data'];
    List<LatestMessageDataModel> dataList =
        dataJson.map((data) => LatestMessageDataModel.fromJson(data)).toList();

    return LatestMessagesModel(
      data: dataList,
      message: json['message'],
      code: json['code'],
      type: json['type'],
    );
  }

  @override
  List<Object> get props => [data, message, code, type];
}

class LatestMessageDataModel extends Equatable {
  final int otherUserId;
  final String name;
  final String avatar;
  final bool fromLoggedUser;
  final int unseenMessagesCount;
  final String createdAt;
  final String messageBody;

  const LatestMessageDataModel({
    required this.otherUserId,
    required this.name,
    required this.avatar,
    required this.fromLoggedUser,
    required this.unseenMessagesCount,
    required this.createdAt,
    required this.messageBody,
  });
  factory LatestMessageDataModel.fromJson(Map<String, dynamic> json) {
    return LatestMessageDataModel(
      otherUserId: json['otherUserId'],
      name: json['name'],
      avatar: json['avatar'],
      fromLoggedUser: json['fromLoggedUser'],
      unseenMessagesCount: json['unseenMessagesCount'],
      createdAt: json['createdAt'],
      messageBody: json['messageBody'],
    );
  }
  @override
  List<Object> get props => [
        otherUserId,
        name,
        avatar,
        fromLoggedUser,
        unseenMessagesCount,
        createdAt,
        messageBody,
      ];
}