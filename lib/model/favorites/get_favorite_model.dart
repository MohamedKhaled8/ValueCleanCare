class GetFavoriteModel {
  int? statusCode;
  bool? status;
  List<Data>? data = [];

  GetFavoriteModel({this.statusCode, this.status, this.data});

  GetFavoriteModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  List<Service>? service = [];

  Data({this.id, this.service});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    json['service'].forEach((v) {
      service!.add(Service.fromJson(v));
    });
  }
}

class Service {
  int? id;
  String? title;
  String? description;
  double? price;
  String? category;
  int? active;
  List<Workers>? workers = [];
  String? images;
  List<Review>? review = [];
  String? createdAt;
  String? updatedAt;
  double? rate;
  bool? isFavorite;

  Service(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.category,
      this.active,
      this.workers,
      this.images,
      this.review,
      this.createdAt,
      this.updatedAt,
      this.rate,
      this.isFavorite});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = double.parse(json['price'].toString());
    category = json['category'];
    active = json['active'];
    json['workers'].forEach((v) {
      workers!.add(Workers.fromJson(v));
    });
    images = json['images'];
    json['Review'].forEach((v) {
      review!.add(Review.fromJson(v));
    });
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = double.parse(json['rate'].toString());
    isFavorite = json['is_favorite'];
  }
}

class Workers {
  int? id;
  String? name;
  String? email;
  String? address;
  int? phone;
  int? active;
  List<Review>? review = [];
  int? count;
  String? photo;

  Workers(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.active,
      this.review,
      this.count,
      this.photo});

  Workers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    active = json['active'];
    json['review'].forEach((v) {
      review!.add(Review.fromJson(v));
    });
    count = json['count'];
    photo = json['photo'];
  }
}

class Review {
  int? id;
  String? comments;
  int? rating;
  List<User>? user = [];
  int? workerId;
  int? rate;

  Review(
      {this.id,
      this.comments,
      this.rating,
      this.user,
      this.workerId,
      this.rate});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    rating = json['rating'];
    json['user'].forEach((v) {
      user!.add(User.fromJson(v));
    });
    workerId = json['worker_id'];
    rate = json['rate'];
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? phone;
  int? niN;
  String? photo;
  String? type;
  int? companyId;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.niN,
    this.photo,
    this.type,
    this.companyId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    niN = json['NiN'];
    photo = json['photo'];
    type = json['type'];
    companyId = json['companyId'];
  }
}

class ReviewTwo {
  int? id;
  String? comments;
  int? rating;
  List<UserTwo>? userTwo = [];
  int? serviceId;

  ReviewTwo(
      {this.id, this.comments, this.rating, this.userTwo, this.serviceId});

  ReviewTwo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    rating = json['rating'];
    json['user'].forEach((v) {
      userTwo!.add(UserTwo.fromJson(v));
    });
    serviceId = json['service_id'];
  }
}

class UserTwo {
  int? id;
  String? name;
  String? email;
  String? photo;

  UserTwo({this.id, this.name, this.email, this.photo});

  UserTwo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
}
