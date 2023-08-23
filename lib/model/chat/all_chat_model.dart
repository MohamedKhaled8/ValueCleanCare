import 'package:equatable/equatable.dart';

class ChatMessageModel extends Equatable {
  final Data data;
  final String message;
  final int code;
  final String type;

  const ChatMessageModel({
    required this.data,
    required this.message,
    required this.code,
    required this.type,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      code: json['code'],
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [message, code, type, data];
}

class Data extends Equatable {
  final int userId;
  final String name;
  final String avatar;
  final List<Messages> messages;

  const Data({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.messages,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
      messages: List<Messages>.from(
          json['messages'].map((message) => Messages.fromJson(message))),
    );
  }

  @override
  List<Object?> get props => [userId, name, avatar, messages];
}

class Messages extends Equatable {
  final int id;
  final bool fromLoggedUser;
  final bool seen;
  final String createdAt;
  final bool updatedBefore;
  final String body;
 final List<Attachments> attachments;
  const Messages({
    required this.id,
    required this.fromLoggedUser,
    required this.seen,
    required this.createdAt,
    required this.updatedBefore,
    required this.body,
    required this.attachments,
  });

  @override
  List<Object?> get props => [
        id,
        fromLoggedUser,
        seen,
        createdAt,
        updatedBefore,
        body,
        attachments,
      ];

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'],
      fromLoggedUser: json['fromLoggedUser'],
      seen: json['seen'],
      createdAt: json['createdAt'],
      updatedBefore: json['updatedBefore'],
      body: json['body'],

        attachments: (json['attachments'] as List<dynamic>).map(
        (attachment) => Attachments.fromJson(attachment),
      ).toList(),
    );
  }
}

class Attachments {
  final String type;
  final String mimeType;
  final String url;

  Attachments({
    required this.type,
    required this.mimeType,
    required this.url,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      type: json['type'],
      mimeType: json['mimeType'],
      url: json['url'],
    );
  }
}