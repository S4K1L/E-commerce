class User {
  final int userId;
  final String fullName;
  final String email;
  final String phone;
  final String? image;
  final String? shopName;
  final String? shopAddress;
  final dynamic area; 
  final String areaName;
  final bool isApproved;
  final bool isActive;
  final bool isStaff;
  final bool isSuperuser;
  final DateTime dateJoined;
  final DateTime createdOn;
  final DateTime updatedOn;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    this.image,
    this.shopName,
    this.shopAddress,
    required this.area,
    required this.areaName,
    required this.isApproved,
    required this.isActive,
    required this.isStaff,
    required this.isSuperuser,
    required this.dateJoined,
    required this.createdOn,
    required this.updatedOn,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      shopName: json['shop_name'],
      shopAddress: json['shop_address'],
      area: json['area'], // dynamic (int or String)
      areaName: json['area_name'],
      isApproved: json['is_approved'],
      isActive: json['is_active'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      dateJoined: DateTime.parse(json['date_joined']),
      createdOn: DateTime.parse(json['created_on']),
      updatedOn: DateTime.parse(json['updated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'image': image,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'area': area,
      'area_name': areaName,
      'is_approved': isApproved,
      'is_active': isActive,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'date_joined': dateJoined.toIso8601String(),
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
    };
  }
}
