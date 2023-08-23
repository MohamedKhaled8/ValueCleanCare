class TermsAndConditionsModel {
  bool success;
  String termsAndConditions;

  TermsAndConditionsModel({
    required this.success,
    required this.termsAndConditions,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsAndConditionsModel(
      success: json['success'],
      termsAndConditions: json['termsAndConditions'],
    );
  }
}
