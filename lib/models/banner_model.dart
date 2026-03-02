class BannerModel {
  final int bannerId;
  final String name;
  final String image;
  final DateTime createdOn;

  BannerModel({
    required this.bannerId,
    required this.name,
    required this.image,
    required this.createdOn,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerId: json['banner_id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      createdOn: DateTime.parse(json['created_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_id': bannerId,
      'name': name,
      'image': image,
      'created_on': createdOn.toIso8601String(),
    };
  }
}
