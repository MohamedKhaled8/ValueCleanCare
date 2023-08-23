class FqaModel {
 final  bool success;
 final List<Fqa> fqa;

  FqaModel({
    required this.success,
    required this.fqa,
  });

  factory FqaModel.fromJson(Map<String, dynamic> json) {
    return FqaModel(
      success: json['success'],
      fqa: List<Fqa>.from(
        json['fqa'].map((fqaJson) => Fqa.fromJson(fqaJson)),
      ),
    );
  }
}

class Fqa {
  int id;
  String title;
  String content;
  String createdAt;
  String updatedAt;

  Fqa({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Fqa.fromJson(Map<String, dynamic> json) {
    return Fqa(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
