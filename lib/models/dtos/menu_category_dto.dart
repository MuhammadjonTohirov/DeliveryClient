import 'package:delivery_client/models/dtos/menu_item_dto.dart';

// Corresponds to MenuCategory and MenuCategoryRequest in OpenAPI spec

class MenuCategoryDto {
  final String id;
  final String restaurant; // restaurantId
  final String name;
  final String? description;
  final int? order;
  final List<MenuItemDto>? items; // Included in full MenuCategory response

  MenuCategoryDto({
    required this.id,
    required this.restaurant,
    required this.name,
    this.description,
    this.order,
    this.items,
  });

  factory MenuCategoryDto.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List?;
    List<MenuItemDto>? menuItems;
    if (itemsList != null) {
      menuItems = itemsList.map((i) => MenuItemDto.fromJson(i)).toList();
    }

    return MenuCategoryDto(
      id: json['id'],
      restaurant: json['restaurant'],
      name: json['name'],
      description: json['description'],
      order: json['order'],
      items: menuItems,
    );
  }
}

class MenuCategoryRequestDto {
  final String restaurant; // restaurantId
  final String name;
  final String? description;
  final int? order;

  MenuCategoryRequestDto({required this.restaurant, required this.name, this.description, this.order});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'restaurant': restaurant, 'name': name};
    if (description != null) data['description'] = description;
    if (order != null) data['order'] = order;
    return data;
  }
}
