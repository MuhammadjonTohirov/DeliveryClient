import 'package:delivery_client/models/dtos/menu_category_dto.dart';
import 'package:delivery_client/models/dtos/menu_item_dto.dart';

// Corresponds to Restaurant in OpenAPI spec (full detail)
class RestaurantDto {
  final String id;
  final String user; // userId of owner
  final String name;
  final String address;
  final String? locationLat;
  final String? locationLng;
  final String? description;
  final String? logo; // URL string
  final bool? isOpen;
  final String? openingTime; // "HH:MM:SS"
  final String? closingTime; // "HH:MM:SS"
  final String createdAt;
  final String updatedAt;
  final List<MenuCategoryDto>? menuCategories;
  final List<MenuItemDto>? menuItems; // API might provide this flat list as well
  final String? averageRating; // API sends as string
  final String ownerName;

  RestaurantDto({
    required this.id,
    required this.user,
    required this.name,
    required this.address,
    this.locationLat,
    this.locationLng,
    this.description,
    this.logo,
    this.isOpen,
    this.openingTime,
    this.closingTime,
    required this.createdAt,
    required this.updatedAt,
    this.menuCategories,
    this.menuItems,
    this.averageRating,
    required this.ownerName,
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    var categoriesList = json['menu_categories'] as List?;
    List<MenuCategoryDto>? categories;
    if (categoriesList != null) {
      categories = categoriesList.map((i) => MenuCategoryDto.fromJson(i)).toList();
    }

    var itemsList = json['menu_items'] as List?;
    List<MenuItemDto>? items;
    if (itemsList != null) {
      items = itemsList.map((i) => MenuItemDto.fromJson(i)).toList();
    }

    return RestaurantDto(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      address: json['address'],
      locationLat: json['location_lat']?.toString(),
      locationLng: json['location_lng']?.toString(),
      description: json['description'],
      logo: json['logo'],
      isOpen: json['is_open'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      menuCategories: categories,
      menuItems: items,
      averageRating: json['average_rating']?.toString(),
      ownerName: json['owner_name'] ?? 'N/A',
    );
  }
}

// Corresponds to RestaurantList in OpenAPI spec (simplified for lists)
class RestaurantListDto {
  final String id;
  final String name;
  final String address;
  final String? description;
  final String? logo;
  final bool? isOpen;
  final String? averageRating;
  final String ownerName;

  RestaurantListDto({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    this.logo,
    this.isOpen,
    this.averageRating,
    required this.ownerName,
  });

  factory RestaurantListDto.fromJson(Map<String, dynamic> json) {
    return RestaurantListDto(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      logo: json['logo'],
      isOpen: json['is_open'],
      averageRating: json['average_rating']?.toString(),
      ownerName: json['owner_name'] ?? 'N/A',
    );
  }
}

// Corresponds to RestaurantRequest in OpenAPI spec
class RestaurantRequestDto {
  final String name;
  final String address;
  final String? locationLat;
  final String? locationLng;
  final String? description;
  // final String? logo; // Image upload handled differently
  final bool? isOpen;
  final String? openingTime; // "HH:MM:SS"
  final String? closingTime; // "HH:MM:SS"

  RestaurantRequestDto({
    required this.name,
    required this.address,
    this.locationLat,
    this.locationLng,
    this.description,
    // this.logo,
    this.isOpen,
    this.openingTime,
    this.closingTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'name': name, 'address': address};
    if (locationLat != null) data['location_lat'] = locationLat;
    if (locationLng != null) data['location_lng'] = locationLng;
    if (description != null) data['description'] = description;
    if (isOpen != null) data['is_open'] = isOpen;
    if (openingTime != null) data['opening_time'] = openingTime;
    if (closingTime != null) data['closing_time'] = closingTime;
    return data;
  }
}
