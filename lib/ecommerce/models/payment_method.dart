import 'package:flutter/material.dart';

class PaymentMethodModel {
  final String id;
  final String name;
  final String group;
  final IconData icon;
  final Color iconColor;

  const PaymentMethodModel({
    required this.id,
    required this.name,
    required this.group,
    required this.icon,
    required this.iconColor,
  });
}
