
// ignore_for_file: file_names

class SubServiceModel {
    int? statusCode;
    bool? status;
    List<Data>? data;

    SubServiceModel({
         this.statusCode,
         this.status,
         this.data,
    });

    factory SubServiceModel.fromJson(Map<String, dynamic> json) => SubServiceModel(
        statusCode: json["statusCode"],
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

   
}

class Data {
   final int id;
  final  String title;
  final  int price;
  final  int serviceId;
  final  String createdAt;
  final  String updatedAt;

    Data({
        required this.id,
        required this.title,
        required this.price,
        required this.serviceId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        serviceId: json["service_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

}
