class DeleteNotificationModel {
  final String message;
  final int statusCode;
  final bool status;
  DeleteNotificationModel(
      {required this.message, required this.status, required this.statusCode});
  factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) {
    return DeleteNotificationModel(
      statusCode: json['statusCode'] as int,
      status: json['status'] as bool,
      message: json['message'] as String,
    );
  }
}
