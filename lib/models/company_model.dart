class CompanyModel {
  final int companyId;
  final String companyName;
  final String? logo;
  final bool isActive;
  final DateTime createdOn;
  final DateTime updatedOn;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    this.logo,
    required this.isActive,
    required this.createdOn,
    required this.updatedOn,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companyId: json['company_id'],
      companyName: json['company_name'],
      logo: json['logo'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'company_name': companyName,
      'logo': logo,
      'is_active': isActive,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
    };
  }
}
