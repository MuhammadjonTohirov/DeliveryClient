import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Added for TimeOfDay
import 'package:delivery_client/models/menu_category_model.dart';
import 'package:delivery_client/models/menu_item_model.dart';
// import 'package:delivery_client/models/restaurant_review_model.dart'; // To be created

@immutable
class Restaurant {
  final String id;
  final String userId; // Owner's user ID
  final String name;
  final String address; // Full address string
  final double? locationLat;
  final double? locationLng;
  final String? description;
  final String? logoUrl;
  final bool isOpen;
  final TimeOfDay? openingTime; // Using TimeOfDay for easier UI integration
  final TimeOfDay? closingTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuCategory> menuCategories;
  final List<MenuItem> menuItems; // Can be a flat list or derived from categories
  final double averageRating;
  final int totalReviews; // Added based on UI requirement for review summary
  final String ownerName; // From API

  // UI specific or derived
  final String? heroImageUrl; // For restaurant detail screen
  final String? cuisineType; // Should be derived or part of restaurant data
  final int? deliveryTimeEstimateMinutes;
  final double? deliveryFee;
  final String? distance; // e.g. "2.5 km"
  final bool isFavorite; // To be managed by user's favorites list
  final List<String> promotionalBadges; // e.g., "Free Delivery", "20% Off"

  const Restaurant({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    this.locationLat,
    this.locationLng,
    this.description,
    this.logoUrl,
    required this.isOpen,
    this.openingTime,
    this.closingTime,
    required this.createdAt,
    required this.updatedAt,
    this.menuCategories = const [],
    this.menuItems = const [],
    this.averageRating = 0.0,
    this.totalReviews = 0,
    required this.ownerName,
    this.heroImageUrl,
    this.cuisineType,
    this.deliveryTimeEstimateMinutes,
    this.deliveryFee,
    this.distance,
    this.isFavorite = false,
    this.promotionalBadges = const [],
  });

  Restaurant copyWith({
    String? id,
    String? userId,
    String? name,
    String? address,
    double? locationLat,
    double? locationLng,
    String? description,
    String? logoUrl,
    bool? isOpen,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MenuCategory>? menuCategories,
    List<MenuItem>? menuItems,
    double? averageRating,
    int? totalReviews,
    String? ownerName,
    String? heroImageUrl,
    String? cuisineType,
    int? deliveryTimeEstimateMinutes,
    double? deliveryFee,
    String? distance,
    bool? isFavorite,
    List<String>? promotionalBadges,
  }) {
    return Restaurant(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      address: address ?? this.address,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      isOpen: isOpen ?? this.isOpen,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      menuCategories: menuCategories ?? this.menuCategories,
      menuItems: menuItems ?? this.menuItems,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      ownerName: ownerName ?? this.ownerName,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      cuisineType: cuisineType ?? this.cuisineType,
      deliveryTimeEstimateMinutes: deliveryTimeEstimateMinutes ?? this.deliveryTimeEstimateMinutes,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      distance: distance ?? this.distance,
      isFavorite: isFavorite ?? this.isFavorite,
      promotionalBadges: promotionalBadges ?? this.promotionalBadges,
    );
  }

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, isOpen: $isOpen, averageRating: $averageRating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Restaurant && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Helper to parse time string like "10:00:00" to TimeOfDay
TimeOfDay? parseTimeOfDay(String? timeString) {
  if (timeString == null) return null;
  try {
    final parts = timeString.split(':');
    if (parts.length >= 2) {
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }
  } catch (e) {
    print("Error parsing time string '$timeString': $e");
  }
  return null;
}
