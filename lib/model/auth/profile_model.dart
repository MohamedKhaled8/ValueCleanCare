// ignore_for_file: non_constant_identifier_names

class ProfileModel {
  final int statusCode;
  final bool status;
  final UserData userData;

  ProfileModel({
    required this.statusCode,
    required this.status,
    required this.userData,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      statusCode: json['statusCode'],
      status: json['status'],
      userData: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final List address;
  final dynamic phone;
  final String photo;
  final int NIN;
  final String type;
  int? companyId;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.photo,
    this.NIN = 0,
    required this.type,
    this.companyId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      photo: json['photo'],
      NIN: json['NiN'], //return with Null
      type: json['type'],
      companyId: json['companyId'],
    );
  }
}
