import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu.dart';
import '../network/dto/restaurant_dto.dart';
import '../network/dto/menu_dto.dart';
import '../network/dto/base_dto.dart' as dto;

class RestaurantMapper {
  static Restaurant fromDto(RestaurantDto dto) {
    return Restaurant(
      id: dto.id,
      userId: dto.user,
      name: dto.name,
      address: dto.address,
      locationLat: dto.locationLat != null
          ? double.tryParse(dto.locationLat!)
          : null,
      locationLng: dto.locationLng != null
          ? double.tryParse(dto.locationLng!)
          : null,
      description: dto.description,
      logoUrl: dto.logo,
      isOpen: dto.isOpen,
      openingTime: dto.openingTime,
      closingTime: dto.closingTime,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      menuCategories: dto.menuCategories
          .map((categoryDto) => MenuCategoryMapper.fromDto(categoryDto))
          .toList(),
      menuItems: dto.menuItems
          .map((itemDto) => MenuItemMapper.fromDto(itemDto))
          .toList(),
      averageRating: double.tryParse(dto.averageRating) ?? 0.0,
      ownerName: dto.ownerName,
    );
  }

  static RestaurantSummary fromListDto(RestaurantListDto dto) {
    return RestaurantSummary(
      id: dto.id,
      name: dto.name,
      address: dto.address,
      description: dto.description,
      logoUrl: dto.logo,
      isOpen: dto.isOpen,
      averageRating: double.tryParse(dto.averageRating) ?? 0.0,
      ownerName: dto.ownerName,
    );
  }

  static RestaurantReview fromReviewDto(RestaurantReviewDto dto) {
    return RestaurantReview(
      id: dto.id,
      restaurantId: dto.restaurant,
      userId: dto.user,
      userFullName: dto.userFullName,
      rating: dto.rating.value,
      comment: dto.comment,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static RestaurantRequestDto toRequestDto({
    required String name,
    required String address,
    double? locationLat,
    double? locationLng,
    String? description,
    bool? isOpen,
    String? openingTime,
    String? closingTime,
  }) {
    return RestaurantRequestDto(
      name: name,
      address: address,
      locationLat: locationLat?.toString(),
      locationLng: locationLng?.toString(),
      description: description,
      isOpen: isOpen,
      openingTime: openingTime,
      closingTime: closingTime,
    );
  }

  static RestaurantReviewRequestDto toReviewRequestDto({
    required String restaurantId,
    required int rating,
    String? comment,
  }) {
    return RestaurantReviewRequestDto(
      restaurant: restaurantId,
      rating: dto.Rating.fromInt(rating),
      comment: comment,
    );
  }
}

class MenuCategoryMapper {
  static MenuCategory fromDto(MenuCategoryDto dto) {
    return MenuCategory(
      id: dto.id,
      restaurantId: dto.restaurant,
      name: dto.name,
      description: dto.description,
      order: dto.order,
      items: dto.items
          .map((itemDto) => MenuItemMapper.fromDto(itemDto))
          .toList(),
    );
  }

  static MenuCategoryRequestDto toRequestDto({
    required String restaurantId,
    required String name,
    String? description,
    int? order,
  }) {
    return MenuCategoryRequestDto(
      restaurant: restaurantId,
      name: name,
      description: description,
      order: order,
    );
  }
}

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
      isAvailable: dto.isAvailable,
      isFeatured: dto.isFeatured,
      preparationTimeMinutes: dto.preparationTime,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  static MenuItemRequestDto toRequestDto({
    required String restaurantId,
    String? categoryId,
    required String name,
    String? description,
    required double price,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
  }) {
    return MenuItemRequestDto(
      restaurant: restaurantId,
      category: categoryId,
      name: name,
      description: description,
      price: price.toString(),
      isAvailable: isAvailable,
      isFeatured: isFeatured,
      preparationTime: preparationTimeMinutes,
    );
  }
}
