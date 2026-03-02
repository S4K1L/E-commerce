class NoticeModel {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final int createdBy;

  NoticeModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.createdBy,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isActive: json['is_active'],
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      'created_by': createdBy,
    };
  }
}
