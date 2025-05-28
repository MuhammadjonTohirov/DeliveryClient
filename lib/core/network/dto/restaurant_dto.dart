import 'base_dto.dart';
import 'menu_dto.dart';

class RestaurantDto {
  final String id;
  final String user;
  final String name;
  final String address;
  final String? locationLat;
  final String? locationLng;
  final String? description;
  final String? logo;
  final bool isOpen;
  final String? openingTime;
  final String? closingTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MenuCategoryDto> menuCategories;
  final List<MenuItemDto> menuItems;
  final String averageRating;
  final String ownerName;

  const RestaurantDto({
    required this.id,
    required this.user,
    required this.name,
    required this.address,
    this.locationLat,
    this.locationLng,
    this.description,
    this.logo,
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

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    return RestaurantDto(
      id: json['id'] as String,
      user: json['user'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      locationLat: json['location_lat'] as String?,
      locationLng: json['location_lng'] as String?,
      description: json['description'] as String?,
      logo: json['logo'] as String?,
      isOpen: json['is_open'] as bool,
      openingTime: json['opening_time'] as String?,
      closingTime: json['closing_time'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      menuCategories: (json['menu_categories'] as List<dynamic>?)
              ?.map((category) => MenuCategoryDto.fromJson(category as Map<String, dynamic>))
              .toList() ??
          [],
      menuItems: (json['menu_items'] as List<dynamic>?)
              ?.map((item) => MenuItemDto.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      averageRating: json['average_rating'] as String,
      ownerName: json['owner_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'address': address,
      'location_lat': locationLat,
      'location_lng': locationLng,
      'description': description,
      'logo': logo,
      'is_open': isOpen,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'menu_categories': menuCategories.map((category) => category.toJson()).toList(),
      'menu_items': menuItems.map((item) => item.toJson()).toList(),
      'average_rating': averageRating,
      'owner_name': ownerName,
    };
  }
}

class RestaurantListDto {
  final String id;
  final String name;
  final String address;
  final String? description;
  final String? logo;
  final bool isOpen;
  final String averageRating;
  final String ownerName;

  const RestaurantListDto({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    this.logo,
    required this.isOpen,
    required this.averageRating,
    required this.ownerName,
  });

  factory RestaurantListDto.fromJson(Map<String, dynamic> json) {
    return RestaurantListDto(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      logo: json['logo'] as String?,
      isOpen: json['is_open'] as bool,
      averageRating: json['average_rating'] as String,
      ownerName: json['owner_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'logo': logo,
      'is_open': isOpen,
      'average_rating': averageRating,
      'owner_name': ownerName,
    };
  }
}

class RestaurantRequestDto {
  final String name;
  final String address;
  final String? locationLat;
  final String? locationLng;
  final String? description;
  final bool? isOpen;
  final String? openingTime;
  final String? closingTime;

  const RestaurantRequestDto({
    required this.name,
    required this.address,
    this.locationLat,
    this.locationLng,
    this.description,
    this.isOpen,
    this.openingTime,
    this.closingTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'location_lat': locationLat,
      'location_lng': locationLng,
      'description': description,
      'is_open': isOpen,
      'opening_time': openingTime,
      'closing_time': closingTime,
    };
  }
}

class RestaurantReviewDto {
  final String id;
  final String restaurant;
  final String user;
  final String userFullName;
  final Rating rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RestaurantReviewDto({
    required this.id,
    required this.restaurant,
    required this.user,
    required this.userFullName,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantReviewDto.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewDto(
      id: json['id'] as String,
      restaurant: json['restaurant'] as String,
      user: json['user'] as String,
      userFullName: json['user_full_name'] as String,
      rating: Rating.fromInt(json['rating'] as int),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant': restaurant,
      'user': user,
      'user_full_name': userFullName,
      'rating': rating.value,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class RestaurantReviewRequestDto {
  final String restaurant;
  final Rating rating;
  final String? comment;

  const RestaurantReviewRequestDto({
    required this.restaurant,
    required this.rating,
    this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant,
      'rating': rating.value,
      'comment': comment,
    };
  }
}
