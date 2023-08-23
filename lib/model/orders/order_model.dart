class OrdersModel {
  int? statusCode;
  bool? status;
  List<Data>? data = [];

  OrdersModel({this.statusCode, this.status, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? workArea;
  String? date;
  String? time;
  int? day;
  String? address;
  String? repeat;
  String? status;
  String? paymentStatus;
  List<Service>? service = [];
  List<Workers>? workers = [];
  int? totalPrice;
  int? offer;
  String? orderCode;
  List<SubService>? subService = [];
  List<Requirement>? requirement = [];
  List<Count>? count = [];
  String? createdAt;
  String? updatedAt;
  // List<Null>? gallery1;

  Data({
    this.id,
    this.workArea,
    this.date,
    this.time,
    this.day,
    this.address,
    this.repeat,
    this.status,
    this.paymentStatus,
    this.service,
    this.workers,
    this.totalPrice,
    this.offer,
    this.orderCode,
    this.subService,
    this.requirement,
    this.count,
    this.createdAt,
    this.updatedAt,
    // this.gallery1,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workArea = json['work_area'];
    date = json['date'];
    time = json['time'];
    day = json['day'];
    address = json['address'];
    repeat = json['repeat'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    if (json['service'] != null) {
      json['service'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
    if (json['workers'] != null) {
      json['workers'].forEach((v) {
        workers!.add(Workers.fromJson(v));
      });
    }
    totalPrice = json['total_price'];
    offer = json['offer'];
    orderCode = json['order_code'];
    if (json['subService'] != null) {
      json['subService'].forEach((v) {
        subService!.add(SubService.fromJson(v));
      });
    }
    if (json['requirement'] != null) {
      json['requirement'].forEach((v) {
        requirement!.add(Requirement.fromJson(v));
      });
    }
    if (json['count'] != null) {
      json['count'].forEach((v) {
        count!.add(Count.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['gallery1'] != null) {
    //   json['gallery1'].forEach((v) {
    //     gallery1!.add( Null.fromJson(v));
    //   });
    // }
  }
}

class Service {
  int? id;
  String? title;
  String? description;
  int? price;
  String? category;
  int? active;
  List<Workers>? workers = [];
  String? images;
  List<Review>? review = [];
  String? createdAt;
  String? updatedAt;
  num? rate;
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
    price = json['price'];
    category = json['category'];
    active = json['active'];
    if (json['workers'] != null) {
      json['workers'].forEach((v) {
        workers!.add(Workers.fromJson(v));
      });
    }
    images = json['images'];
    if (json['Review'] != null) {
      json['Review'].forEach((v) {
        review!.add(Review.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = json['rate'];
    isFavorite = json['is_favorite'];
  }
}

class ServiceWorkers {
  int? id;
  String? name;
  String? email;
  // List<Null>? review=[];
  String? photo;

  ServiceWorkers(
      {this.id,
      this.name,
      this.email,
      //  this.review,
      this.photo});

  ServiceWorkers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
}

class Review {
  int? id;
  String? comments;
  int? rating;
  List<User>? user = [];
  int? serviceId;

  Review({this.id, this.comments, this.rating, this.user, this.serviceId});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    rating = json['rating'];
    if (json['user'] != null) {
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    serviceId = json['service_id'];
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? photo;

  User({this.id, this.name, this.email, this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }
}

class Workers {
  int? id;
  String? name;
  String? email;
  String? address;
  int? latitude;
  int? longitude;
  int? phone;
  int? nIN;
  int? active;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Workers(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.latitude,
      this.longitude,
      this.phone,
      this.nIN,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Workers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    nIN = json['NIN'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
}

class Pivot {
  int? orderId;
  int? workerId;

  Pivot({this.orderId, this.workerId});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    workerId = json['worker_id'];
  }
}

class SubService {
  int? id;
  String? title;
  int? price;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  SubService(
      {this.id,
      this.title,
      this.price,
      this.serviceId,
      this.createdAt,
      this.updatedAt});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Requirement {
  int? id;
  String? title;
  int? requirementPrice;
  int? serviceId;
  String? createdAt;
  String? updatedAt;

  Requirement(
      {this.id,
      this.title,
      this.requirementPrice,
      this.serviceId,
      this.createdAt,
      this.updatedAt});

  Requirement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    requirementPrice = json['requirement_price'];
    serviceId = json['service_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Count {
  int? count;

  Count({this.count});

  Count.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
