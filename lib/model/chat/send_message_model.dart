import 'package:equatable/equatable.dart';

class SendMessageModel extends Equatable {
  final MessageContent data;
  final String message;
  final int code;
  final String type;

  const SendMessageModel({
    required this.data,
    required this.message,
    required this.code,
    required this.type,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    return SendMessageModel(
      data: MessageContent.fromJson(json['data']),
      message: json['message'],
      code: json['code'],
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [data, message, code, type];
}

class MessageContent extends Equatable {
  final int id;
  final int fromUserId;
  final int toUserId;
  final String body;
  final bool fromLoggedUser;
  final bool seen;
  final bool updatedBefore;
  final String createdAt;
  final List<Attachment>? attachments;

  const MessageContent({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.body,
    required this.fromLoggedUser,
    required this.seen,
    required this.updatedBefore,
    required this.createdAt,
    required this.attachments,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      id: json['id'],
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      body: json['body'],
      fromLoggedUser: json['fromLoggedUser'],
      seen: json['seen'],
      updatedBefore: json['updatedBefore'],
      createdAt: json['createdAt'],
      attachments: (json['attachments'] as List<dynamic>)
          .map((attachment) => Attachment.fromJson(attachment))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        fromUserId,
        toUserId,
        body,
        fromLoggedUser,
        seen,
        updatedBefore,
        createdAt,
        attachments
      ];
}

class Attachment extends Equatable {
  final String url;
  final String mimeType;
  final String type;

  const Attachment({
    required this.url,
    required this.mimeType,
    required this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      url: json['url'],
      mimeType: json['mimeType'],
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [url, mimeType, type];
}
