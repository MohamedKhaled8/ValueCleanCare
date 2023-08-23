class UserHomeModel {
  int? notification;
  List<Announcement>? announcement;
  List<Service>? service;
  List<TopServiceModel>? topService;
  List<Subcategory>? subsubcategories;

  UserHomeModel({
    this.notification,
    this.announcement,
    this.service,
    this.topService,
    this.subsubcategories,
  });

  factory UserHomeModel.fromJson(Map<String, dynamic> json) => UserHomeModel(
        notification: json["notification"],
        announcement: json["announcement"] == null
            ? []
            : List<Announcement>.from(
                json["announcement"]!.map((x) => Announcement.fromJson(x))),
        service: json["service"] == null
            ? []
            : List<Service>.from(
                json["service"]!.map((x) => Service.fromJson(x))),
        topService: json["topService"] == null
            ? []
            : List<TopServiceModel>.from(
                json["topService"]!.map((x) => TopServiceModel.fromJson(x))),
        subsubcategories: json["subsubcategories"] == null
            ? []
            : List<Subcategory>.from(
                json["subsubcategories"]!.map((x) => Subcategory.fromJson(x))),
      );
}

class Announcement {
  int id;
  String title;
  String photo;

  Announcement({
    required this.id,
    required this.title,
    required this.photo,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        title: json["title"],
        photo: json["photo"],
      );
}

class Service {
  int id;
  String title;
  String description;
  int price;
  String category;
  int active;
  List<Worker>? workers = [];
  String images;
  List<Review>? review = [];
  String createdAt;
  String updatedAt;
  num rate;
  bool isFavorite;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.active,
    this.workers,
    required this.images,
    this.review,
    required this.createdAt,
    required this.updatedAt,
    required this.rate,
    required this.isFavorite,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        active: json["active"],
        workers: json["workers"] == null
            ? []
            : List<Worker>.from(
                json["workers"]!.map((x) => Worker.fromJson(x))),
        images: json["images"],
        review: json["Review"] == null
            ? []
            : List<Review>.from(json["Review"]!.map((x) => Review.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rate: json["rate"]?.toDouble(),
        isFavorite: json["is_favorite"],
      );
}
class TopServiceModel
 {
  int id;
  String title;
  String description;
  int price;
  String category;
  int active;
  List<Worker>? workers = [];
  String images;
  List<Review>? review = [];
  String createdAt;
  String updatedAt;
  num rate;
  bool isFavorite;

  TopServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.active,
    this.workers,
    required this.images,
    this.review,
    required this.createdAt,
    required this.updatedAt,
    required this.rate,
    required this.isFavorite,
  });

  factory TopServiceModel.fromJson(Map<String, dynamic> json) => TopServiceModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        active: json["active"],
        workers: json["workers"] == null
            ? []
            : List<Worker>.from(
                json["workers"]!.map((x) => Worker.fromJson(x))),
        images: json["images"],
        review: json["Review"] == null
            ? []
            : List<Review>.from(json["Review"]!.map((x) => Review.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rate: json["rate"]?.toDouble(),
        isFavorite: json["is_favorite"],
      );
}

class Review {
  int id;
  String comments;
  int rating;
  List<Worker>? user = [];
  int serviceId;

  Review({
    required this.id,
    required this.comments,
    required this.rating,
    this.user,
    required this.serviceId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        comments: json["comments"],
        rating: json["rating"],
        user: json["user"] == null
            ? []
            : List<Worker>.from(json["user"]!.map((x) => Worker.fromJson(x))),
        serviceId: json["service_id"],
      );
}

class Worker {
  int id;
  String name;
  String email;
  String photo;
  List<ReviewElement>? review = [];

  Worker({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    this.review,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        review: json["review"] == null
            ? []
            : List<ReviewElement>.from(
                json["review"]!.map((x) => ReviewElement.fromJson(x))),
      );
}

class ReviewElement {
  int id;
  String comments;
  num rating;
  List<User>? user = [];
  int workerId;
  num rate;

  ReviewElement({
    required this.id,
    required this.comments,
    required this.rating,
    this.user,
    required this.workerId,
    required this.rate,
  });

  factory ReviewElement.fromJson(Map<String, dynamic> json) => ReviewElement(
        id: json["id"],
        comments: json["comments"],
        rating: json["rating"],
        user: json["user"] == null
            ? []
            : List<User>.from(json["user"]!.map((x) => User.fromJson(x))),
        workerId: json["worker_id"],
        rate: json["rate"],
      );
}

class User {
  int id;
  String name;
  String email;
  List<String>? address = [];
  int phone;
  int niN;
  String photo;
  List<dynamic>? avatar = [];
  String type;
  int companyId;
  List<dynamic>? permission = [];

  User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    required this.phone,
    required this.niN,
    required this.photo,
    this.avatar,
    required this.type,
    required this.companyId,
    this.permission,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: List<String>.from(json["address"].map((x) => x)),
        phone: json["phone"],
        niN: json["NiN"],
        photo: json["photo"],
        avatar: List<dynamic>.from(json["avatar"].map((x) => x)),
        type: json["type"],
        companyId: json["companyId"],
        permission: List<dynamic>.from(json["permission"].map((x) => x)),
      );
}

class Subcategory {
  int id;
  String title;
  String images;
  List<Subcategory>? subCategory = [];
  List<Category>? category = [];

  Subcategory({
    required this.id,
    required this.title,
    required this.images,
    this.subCategory,
    this.category,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        title: json["title"],
        images: json["images"],
        subCategory: json["subCategory"] == null
            ? []
            : List<Subcategory>.from(
                json["subCategory"]!.map((x) => Subcategory.fromJson(x))),
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
      );
}

class Category {
  int id;
  Title title;
  int subCategoryId;
  String createdAt;
  String updatedAt;

  Category({
    required this.id,
    required this.title,
    required this.subCategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: Title.fromJson(json["title"]),
        subCategoryId: json["sub_category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Title {
  String en;
  String sv;

  Title({
    required this.en,
    required this.sv,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"],
        sv: json["sv"],
      );
}
