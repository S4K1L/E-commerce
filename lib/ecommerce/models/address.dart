class AddressModel {
  final String id;
  final String label;
  final String fullAddress;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.isDefault = false,
  });
}
