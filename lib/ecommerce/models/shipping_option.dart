class ShippingOption {
  final String id;
  final String name;
  final String estimatedArrival;
  final double price;

  const ShippingOption({
    required this.id,
    required this.name,
    required this.estimatedArrival,
    required this.price,
  });
}
