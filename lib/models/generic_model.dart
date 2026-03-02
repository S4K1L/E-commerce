class GenericModel {
  final int genericId;
  final String name;
  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;

  GenericModel({
    required this.genericId,
    required this.name,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GenericModel.fromJson(Map<String, dynamic> json) {
    return GenericModel(
      genericId: json['generic_id'],
      name: json['name'],
      description: json['description'] ?? '',
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generic_id': genericId,
      'name': name,
      'description': description,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
    };
  }
}
