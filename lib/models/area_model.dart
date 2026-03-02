class AreaModel {
  final int areaId;
  final String areaName;
  final bool isActive;
  final DateTime createdOn;
  final int? createdBy;
  final DateTime updatedOn;
  final int? updatedBy;

  AreaModel({
    required this.areaId,
    required this.areaName,
    required this.isActive,
    required this.createdOn,
    this.createdBy,
    required this.updatedOn,
    this.updatedBy,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      areaId: json['area_id'],
      areaName: json['area_name'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      createdBy: json['created_by'],
      updatedOn: DateTime.parse(json['updated_on']),
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area_id': areaId,
      'area_name': areaName,
      'is_active': isActive,
      'created_on': createdOn.toIso8601String(),
      'created_by': createdBy,
      'updated_on': updatedOn.toIso8601String(),
      'updated_by': updatedBy,
    };
  }
}
