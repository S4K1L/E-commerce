class ServiceInfo {
  final String name;
  final String logo;
  final String description;
  final String version;
  final double deliveryCharge;
  final String contactEmail;
  final String contactPhone;

  ServiceInfo({
    required this.name,
    required this.logo,
    required this.description,
    required this.version,
    required this.deliveryCharge,
    required this.contactEmail,
    required this.contactPhone,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      version: json['version'] ?? '',
      deliveryCharge: (json['delivery_charge'] as num?)?.toDouble() ?? 0.0,
      contactEmail: json['contact_email'] ?? '',
      contactPhone: json['contact_phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
      'description': description,
      'version': version,
      'delivery_charge': deliveryCharge,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
    };
  }
}
