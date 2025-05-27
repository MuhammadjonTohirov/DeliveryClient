import 'package:flutter/foundation.dart';

// For UI specific badges/indicators not directly in API
class DietaryRestriction {
  final String id;
  final String name;
  final String iconUrl; // Or an IconData

  const DietaryRestriction({required this.id, required this.name, required this.iconUrl});
}

@immutable
class MenuItem {
  final String id;
  final String restaurantId;
  final String? categoryId;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final bool isAvailable;
  final bool isFeatured; // From API
  final int? preparationTimeMinutes; // In minutes
  final DateTime createdAt;
  final DateTime updatedAt;

  // UI specific properties, can be derived or added if API supports later
  final bool isPopular;
  final int? spicyLevel; // e.g., 0 (not spicy), 1, 2, 3 (very spicy)
  final List<DietaryRestriction> dietaryRestrictions;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    this.isAvailable = true,
    this.isFeatured = false,
    this.preparationTimeMinutes,
    required this.createdAt,
    required this.updatedAt,
    this.isPopular = false,
    this.spicyLevel,
    this.dietaryRestrictions = const [],
  });

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? categoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPopular,
    int? spicyLevel,
    List<DietaryRestriction>? dietaryRestrictions,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      preparationTimeMinutes: preparationTimeMinutes ?? this.preparationTimeMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPopular: isPopular ?? this.isPopular,
      spicyLevel: spicyLevel ?? this.spicyLevel,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
    );
  }

  @override
  String toString() {
    return 'MenuItem(id: $id, name: $name, price: $price, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
