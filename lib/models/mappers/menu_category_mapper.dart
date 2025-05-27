import 'package:delivery_client/models/menu_category_model.dart';
import 'package:delivery_client/models/dtos/menu_category_dto.dart';
import 'package:delivery_client/models/mappers/menu_item_mapper.dart';

class MenuCategoryMapper {
  static MenuCategory fromDto(MenuCategoryDto dto) {
    return MenuCategory(
      id: dto.id,
      restaurantId: dto.restaurant,
      name: dto.name,
      description: dto.description,
      order: dto.order ?? 0,
      items: dto.items?.map((itemDto) => MenuItemMapper.fromDto(itemDto)).toList() ?? [],
    );
  }

  static MenuCategoryRequestDto toRequestDto(MenuCategory model) {
    return MenuCategoryRequestDto(
      restaurant: model.restaurantId,
      name: model.name,
      description: model.description,
      order: model.order,
    );
  }
}
