import 'menu.dart';

class Restaurant {
  final String id;
  final String userId;
  final String name;
  final String address;
  final double? locationLat;
  final double? locationLng;
  final String? description;
  final String? logoUrl;
  final bool isOpen;
  final String? openingTime;
  final String? closingTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuCategory> menuCategories;
  final List<MenuItem> menuItems;
  final double averageRating;
  final String ownerName;

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
    required this.menuCategories,
    required this.menuItems,
    required this.averageRating,
    required this.ownerName,
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
    String? openingTime,
    String? closingTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MenuCategory>? menuCategories,
    List<MenuItem>? menuItems,
    double? averageRating,
    String? ownerName,
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
      ownerName: ownerName ?? this.ownerName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Restaurant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class RestaurantSummary {
  final String id;
  final String name;
  final String address;
  final String? description;
  final String? logoUrl;
  final bool isOpen;
  final double averageRating;
  final String ownerName;

  const RestaurantSummary({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    this.logoUrl,
    required this.isOpen,
    required this.averageRating,
    required this.ownerName,
  });

  RestaurantSummary copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
    String? logoUrl,
    bool? isOpen,
    double? averageRating,
    String? ownerName,
  }) {
    return RestaurantSummary(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      isOpen: isOpen ?? this.isOpen,
      averageRating: averageRating ?? this.averageRating,
      ownerName: ownerName ?? this.ownerName,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantSummary &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class RestaurantReview {
  final String id;
  final String restaurantId;
  final String userId;
  final String userFullName;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RestaurantReview({
    required this.id,
    required this.restaurantId,
    required this.userId,
    required this.userFullName,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  RestaurantReview copyWith({
    String? id,
    String? restaurantId,
    String? userId,
    String? userFullName,
    int? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RestaurantReview(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      userId: userId ?? this.userId,
      userFullName: userFullName ?? this.userFullName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantReview &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
