import 'base_dto.dart';

class MenuCategoryDto {
  final String id;
  final String restaurant;
  final String name;
  final String? description;
  final int order;
  final List<MenuItemDto> items;

  const MenuCategoryDto({
    required this.id,
    required this.restaurant,
    required this.name,
    this.description,
    required this.order,
    required this.items,
  });

  factory MenuCategoryDto.fromJson(Map<String, dynamic> json) {
    return MenuCategoryDto(
      id: json['id'] as String,
      restaurant: json['restaurant'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      order: json['order'] as int,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => MenuItemDto.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant': restaurant,
      'name': name,
      'description': description,
      'order': order,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class MenuCategoryRequestDto {
  final String restaurant;
  final String name;
  final String? description;
  final int? order;

  const MenuCategoryRequestDto({
    required this.restaurant,
    required this.name,
    this.description,
    this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant,
      'name': name,
      'description': description,
      'order': order,
    };
  }
}

class MenuItemDto {
  final String id;
  final String restaurant;
  final String? category;
  final String name;
  final String? description;
  final String price;
  final String? image;
  final bool isAvailable;
  final bool isFeatured;
  final int? preparationTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MenuItemDto({
    required this.id,
    required this.restaurant,
    this.category,
    required this.name,
    this.description,
    required this.price,
    this.image,
    required this.isAvailable,
    required this.isFeatured,
    this.preparationTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MenuItemDto.fromJson(Map<String, dynamic> json) {
    return MenuItemDto(
      id: json['id'] as String,
      restaurant: json['restaurant'] as String,
      category: json['category'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: json['price'] as String,
      image: json['image'] as String?,
      isAvailable: json['is_available'] as bool,
      isFeatured: json['is_featured'] as bool,
      preparationTime: json['preparation_time'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant': restaurant,
      'category': category,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'is_available': isAvailable,
      'is_featured': isFeatured,
      'preparation_time': preparationTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class MenuItemRequestDto {
  final String restaurant;
  final String? category;
  final String name;
  final String? description;
  final String price;
  final bool? isAvailable;
  final bool? isFeatured;
  final int? preparationTime;

  const MenuItemRequestDto({
    required this.restaurant,
    this.category,
    required this.name,
    this.description,
    required this.price,
    this.isAvailable,
    this.isFeatured,
    this.preparationTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant,
      'category': category,
      'name': name,
      'description': description,
      'price': price,
      'is_available': isAvailable,
      'is_featured': isFeatured,
      'preparation_time': preparationTime,
    };
  }
}
