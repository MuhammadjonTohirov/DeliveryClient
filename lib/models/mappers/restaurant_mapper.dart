import 'package:flutter/material.dart'; // For TimeOfDay
import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/models/dtos/restaurant_dto.dart';
import 'package:delivery_client/models/mappers/menu_category_mapper.dart';
import 'package:delivery_client/models/mappers/menu_item_mapper.dart';

class RestaurantMapper {
  static Restaurant fromDto(RestaurantDto dto) {
    return Restaurant(
      id: dto.id,
      userId: dto.user,
      name: dto.name,
      address: dto.address,
      locationLat: double.tryParse(dto.locationLat ?? ''),
      locationLng: double.tryParse(dto.locationLng ?? ''),
      description: dto.description,
      logoUrl: dto.logo,
      isOpen: dto.isOpen ?? false,
      openingTime: parseTimeOfDay(dto.openingTime),
      closingTime: parseTimeOfDay(dto.closingTime),
      createdAt: DateTime.tryParse(dto.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(dto.updatedAt) ?? DateTime.now(),
      menuCategories: dto.menuCategories?.map((catDto) => MenuCategoryMapper.fromDto(catDto)).toList() ?? [],
      menuItems: dto.menuItems?.map((itemDto) => MenuItemMapper.fromDto(itemDto)).toList() ?? [],
      averageRating: double.tryParse(dto.averageRating ?? '0.0') ?? 0.0,
      ownerName: dto.ownerName,
      // UI specific fields like totalReviews, heroImageUrl, cuisineType, etc.
      // need to be populated based on additional logic or if API provides them.
      // For now, using defaults or deriving if possible.
      totalReviews: 0, // Placeholder - API doesn't directly provide this in RestaurantDto
      heroImageUrl: dto.logo, // Example: use logo as hero image if no other is specified
      // cuisineType: "Various", // Placeholder - needs to come from API or be derived
    );
  }

  static Restaurant fromListDto(RestaurantListDto dto) {
    // This creates a Restaurant domain model from the simplified List DTO.
    // Some fields will be missing or have default values.
    return Restaurant(
      id: dto.id,
      userId: '', // Not available in ListDto, might need separate fetch or leave empty
      name: dto.name,
      address: dto.address,
      description: dto.description,
      logoUrl: dto.logo,
      isOpen: dto.isOpen ?? false,
      createdAt: DateTime.now(), // Placeholder
      updatedAt: DateTime.now(), // Placeholder
      averageRating: double.tryParse(dto.averageRating ?? '0.0') ?? 0.0,
      ownerName: dto.ownerName,
      // Other fields like menuCategories, menuItems, detailed times, lat/lng will be empty/default
      // These would typically be fetched when navigating to the restaurant detail screen.
      totalReviews: 0, // Placeholder
      // cuisineType: "Various", // Placeholder
    );
  }

  static RestaurantRequestDto toRequestDto(Restaurant model) {
    return RestaurantRequestDto(
      name: model.name,
      address: model.address,
      locationLat: model.locationLat?.toString(),
      locationLng: model.locationLng?.toString(),
      description: model.description,
      isOpen: model.isOpen,
      openingTime: model.openingTime != null
          ? "${model.openingTime!.hour.toString().padLeft(2, '0')}:${model.openingTime!.minute.toString().padLeft(2, '0')}:00"
          : null,
      closingTime: model.closingTime != null
          ? "${model.closingTime!.hour.toString().padLeft(2, '0')}:${model.closingTime!.minute.toString().padLeft(2, '0')}:00"
          : null,
    );
  }
}
