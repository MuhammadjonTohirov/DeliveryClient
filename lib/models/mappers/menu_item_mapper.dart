import 'package:delivery_client/models/menu_item_model.dart';
import 'package:delivery_client/models/dtos/menu_item_dto.dart';

class MenuItemMapper {
  static MenuItem fromDto(MenuItemDto dto) {
    return MenuItem(
      id: dto.id,
      restaurantId: dto.restaurant,
      categoryId: dto.category,
      name: dto.name,
      description: dto.description,
      price: double.tryParse(dto.price) ?? 0.0,
      imageUrl: dto.image,
      isAvailable: dto.isAvailable ?? true,
      isFeatured: dto.isFeatured ?? false,
      preparationTimeMinutes: dto.preparationTime,
      createdAt: DateTime.tryParse(dto.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(dto.updatedAt) ?? DateTime.now(),
      // UI specific fields like isPopular, spicyLevel, dietaryRestrictions
      // would need to be populated from a different source or have defaults.
      // For now, using defaults:
      isPopular: dto.isFeatured ?? false, // Example: equate popular with featured
    );
  }

  static MenuItemRequestDto toRequestDto(MenuItem model) {
    return MenuItemRequestDto(
      restaurant: model.restaurantId,
      category: model.categoryId,
      name: model.name,
      description: model.description,
      price: model.price.toStringAsFixed(2),
      isAvailable: model.isAvailable,
      isFeatured: model.isFeatured,
      preparationTime: model.preparationTimeMinutes,
    );
  }
}
