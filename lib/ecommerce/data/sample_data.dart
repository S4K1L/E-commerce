import 'package:flutter/material.dart';

import '../models/address.dart';
import '../models/category.dart';
import '../models/chat_message.dart';
import '../models/order.dart';
import '../models/payment_method.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/shipping_option.dart';

class SampleData {
  SampleData._();

  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'clothes',
      name: 'Clothes',
      icon: Icons.checkroom_outlined,
      bgColor: Color(0xFFFFE5E7),
    ),
    CategoryModel(
      id: 'electronics',
      name: 'Electronics',
      icon: Icons.devices_other_outlined,
      bgColor: Color(0xFFE7F5FF),
    ),
    CategoryModel(
      id: 'shoes',
      name: 'Shoes',
      icon: Icons.directions_run_outlined,
      bgColor: Color(0xFFFFF4E5),
    ),
    CategoryModel(
      id: 'watch',
      name: 'Watch',
      icon: Icons.watch_outlined,
      bgColor: Color(0xFFEDF7EE),
    ),
    CategoryModel(
      id: 'furniture',
      name: 'Furniture',
      icon: Icons.chair_outlined,
      bgColor: Color(0xFFF3EDFF),
    ),
    CategoryModel(
      id: 'beauty',
      name: 'Beauty',
      icon: Icons.face_retouching_natural,
      bgColor: Color(0xFFFFE7F2),
    ),
    CategoryModel(
      id: 'sports',
      name: 'Sports',
      icon: Icons.sports_basketball_outlined,
      bgColor: Color(0xFFE7FFF2),
    ),
    CategoryModel(
      id: 'books',
      name: 'Books',
      icon: Icons.menu_book_outlined,
      bgColor: Color(0xFFFFF7D6),
    ),
  ];

  static const List<ProductModel> products = [
    ProductModel(
      id: 'p1',
      name: 'Light Brown Coat',
      category: 'Clothes',
      image:
          'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=600&q=80',
      price: 13200,
      oldPrice: 16500,
      rating: 4.5,
      reviewCount: 107,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Read more',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Brown', 'Black', 'Beige'],
      sellerName: 'Jenny Doe',
      sellerRole: 'Manager',
      sellerAvatar:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
      isFeatured: true,
    ),
    ProductModel(
      id: 'p2',
      name: 'Nike Pegasus 39',
      category: 'Shoes',
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
      price: 9900,
      rating: 4.6,
      reviewCount: 88,
      sellerName: 'Joshua Doe',
      sellerRole: 'Manager',
      isPopular: true,
    ),
    ProductModel(
      id: 'p3',
      name: 'Nike Pegasus',
      category: 'Shoes',
      image:
          'https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?w=600&q=80',
      price: 9350,
      rating: 4.4,
      reviewCount: 56,
      sellerName: 'Joshua Doe',
      sellerRole: 'Manager',
    ),
    ProductModel(
      id: 'p4',
      name: 'Nike Pegasus 4.5',
      category: 'Shoes',
      image:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600&q=80',
      price: 12100,
      rating: 4.9,
      reviewCount: 142,
      sellerName: 'Joshua Doe',
      sellerRole: 'Manager',
    ),
    ProductModel(
      id: 'p5',
      name: 'Modern Sofa Chair',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=600&q=80',
      price: 13200,
      rating: 4.5,
      reviewCount: 65,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Read more',
      colors: ['Brown', 'Grey', 'White'],
      sellerName: 'Joshua Doe',
      sellerRole: 'Manager',
      sellerAvatar:
          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80',
      isFeatured: true,
    ),
    ProductModel(
      id: 'p6',
      name: 'Arm Chair',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=600&q=80',
      price: 19800,
      rating: 4.5,
      reviewCount: 22,
    ),
    ProductModel(
      id: 'p7',
      name: 'Sofa Chair',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=600&q=80',
      price: 13200,
      rating: 5.0,
      reviewCount: 18,
    ),
    ProductModel(
      id: 'p8',
      name: 'Wood Chair',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1592078615290-033ee584e267?w=600&q=80',
      price: 12100,
      rating: 4.9,
      reviewCount: 33,
    ),
    ProductModel(
      id: 'p9',
      name: 'Grey Chair',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=600&q=80',
      price: 22000,
      rating: 5.0,
      reviewCount: 12,
    ),
    ProductModel(
      id: 'p10',
      name: 'Sofa Chair Lux',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=600&q=80',
      price: 19800,
      rating: 4.5,
      reviewCount: 41,
    ),
    ProductModel(
      id: 'p11',
      name: 'Wood Chair Pro',
      category: 'Furniture',
      image:
          'https://images.unsplash.com/photo-1581539250439-c96689b516dd?w=600&q=80',
      price: 14300,
      rating: 5.0,
      reviewCount: 27,
    ),
    ProductModel(
      id: 'p12',
      name: 'Apple iPhone 15',
      category: 'Electronics',
      image:
          'https://images.unsplash.com/photo-1592286927505-1def25115558?w=600&q=80',
      price: 109999,
      rating: 4.8,
      reviewCount: 312,
      isPopular: true,
    ),
    ProductModel(
      id: 'p13',
      name: 'Smart Watch Pro',
      category: 'Watch',
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80',
      price: 21890,
      rating: 4.7,
      reviewCount: 144,
    ),
    ProductModel(
      id: 'p14',
      name: 'Headphones X1',
      category: 'Electronics',
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80',
      price: 8690,
      rating: 4.5,
      reviewCount: 60,
    ),
  ];

  static const List<String> bannerImages = [
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900&q=80',
    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=900&q=80',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?w=900&q=80',
  ];

  static const List<AddressModel> addresses = [
    AddressModel(
      id: 'a1',
      label: 'Home',
      fullAddress: 'House 12, Road 7, Dhanmondi, Dhaka 1209',
      isDefault: true,
    ),
    AddressModel(
      id: 'a2',
      label: 'Office',
      fullAddress: 'Plot 45, Gulshan Avenue, Gulshan-1, Dhaka 1212',
    ),
    AddressModel(
      id: 'a3',
      label: "Parent's House",
      fullAddress: 'House 23, Mirpur DOHS, Avenue 5, Dhaka 1216',
    ),
    AddressModel(
      id: 'a4',
      label: "Friend's House",
      fullAddress: 'Flat B5, Bashundhara R/A, Block J, Dhaka 1229',
    ),
  ];

  static const List<ShippingOption> shippingOptions = [
    ShippingOption(
      id: 'economy',
      name: 'Economy',
      estimatedArrival: 'Estimated Arrival 25 Sep 2026',
      price: 60,
    ),
    ShippingOption(
      id: 'regular',
      name: 'Regular',
      estimatedArrival: 'Estimated Arrival 24 Sep 2026',
      price: 100,
    ),
    ShippingOption(
      id: 'cargo',
      name: 'Cargo',
      estimatedArrival: 'Estimated Arrival 22 Sep 2026',
      price: 150,
    ),
    ShippingOption(
      id: 'express',
      name: 'Express',
      estimatedArrival: 'Estimated Arrival 20 Sep 2026',
      price: 250,
    ),
  ];

  static const List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(
      id: 'cash',
      name: 'Cash',
      group: 'Cash',
      icon: Icons.payments_outlined,
      iconColor: Color(0xFFFF4D5E),
    ),
    PaymentMethodModel(
      id: 'wallet',
      name: 'Wallet',
      group: 'Wallet',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Color(0xFFFF4D5E),
    ),
    PaymentMethodModel(
      id: 'card',
      name: 'Add Card',
      group: 'Credit & Debit Card',
      icon: Icons.credit_card,
      iconColor: Color(0xFFFF4D5E),
    ),
    PaymentMethodModel(
      id: 'paypal',
      name: 'Paypal',
      group: 'More Payment Options',
      icon: Icons.payment,
      iconColor: Color(0xFF003087),
    ),
    PaymentMethodModel(
      id: 'apple',
      name: 'Apple Pay',
      group: 'More Payment Options',
      icon: Icons.apple,
      iconColor: Colors.black,
    ),
    PaymentMethodModel(
      id: 'google',
      name: 'Google Pay',
      group: 'More Payment Options',
      icon: Icons.g_mobiledata,
      iconColor: Color(0xFF4285F4),
    ),
  ];

  static const List<ReviewModel> reviews = [
    ReviewModel(
      id: 'r1',
      userName: 'Dale Thiel',
      userAvatar:
          'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=200&q=80',
      rating: 5.0,
      date: '11 months ago',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
    ),
    ReviewModel(
      id: 'r2',
      userName: 'Tiffany Nitzsche',
      userAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
      rating: 5.0,
      date: '11 months ago',
      comment:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    ReviewModel(
      id: 'r3',
      userName: 'Esther Howard',
      userAvatar:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200&q=80',
      rating: 4.5,
      date: '10 months ago',
      comment: 'Great quality! Loved the fit and the colour.',
    ),
  ];

  static List<OrderTimelineEntry> sampleTimeline = const [
    OrderTimelineEntry(
      status: OrderStatus.placed,
      label: 'Order Placed',
      date: '24 Sep 2026 04:18 PM',
      isActive: true,
    ),
    OrderTimelineEntry(
      status: OrderStatus.inProgress,
      label: 'In Progress',
      date: '24 Sep 2026 06:42 PM',
      isActive: true,
    ),
    OrderTimelineEntry(
      status: OrderStatus.shipped,
      label: 'Shipped',
      date: '04 Sep 2026 04:18 PM',
      isActive: true,
    ),
    OrderTimelineEntry(
      status: OrderStatus.delivered,
      label: 'Delivered',
      date: '08 Sep 2026 04:18 PM',
    ),
  ];

  static List<ChatMessageModel> chatMessages = const [
    ChatMessageModel(
      id: 'm1',
      senderName: 'Esther Howard',
      senderAvatar:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200&q=80',
      isMe: false,
      type: ChatMessageType.text,
      content:
          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
      time: '10:24 AM',
    ),
    ChatMessageModel(
      id: 'm2',
      senderName: 'Esther Howard',
      senderAvatar:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200&q=80',
      isMe: false,
      type: ChatMessageType.text,
      content:
          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
      time: '10:25 AM',
    ),
    ChatMessageModel(
      id: 'm3',
      senderName: 'You',
      senderAvatar: '',
      isMe: true,
      type: ChatMessageType.text,
      content:
          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
      time: '10:30 AM',
    ),
    ChatMessageModel(
      id: 'm4',
      senderName: 'You',
      senderAvatar: '',
      isMe: true,
      type: ChatMessageType.image,
      content:
          'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=300&q=80',
      time: '10:31 AM',
    ),
    ChatMessageModel(
      id: 'm5',
      senderName: 'Esther Howard',
      senderAvatar:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200&q=80',
      isMe: false,
      type: ChatMessageType.voice,
      content: '',
      time: '10:34 AM',
      voiceDuration: 28,
    ),
  ];
}
