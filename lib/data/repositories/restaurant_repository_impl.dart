import '../../domain/entities/restaurant.dart';
import '../../domain/entities/menu.dart';
import '../../core/network/services/restaurant_api_service.dart';
import '../../core/mappers/restaurant_mapper.dart';
import '../../core/errors/network_exception.dart';
import '../../core/network/dto/base_dto.dart';

abstract class RestaurantRepository {
  Future<List<RestaurantSummary>> getRestaurants({
    bool? isOpen,
    String? ordering,
    int? page,
    String? search,
  });

  Future<Restaurant> getRestaurantDetails(String id);

  Future<Restaurant> createRestaurant({
    required String name,
    required String address,
    double? locationLat,
    double? locationLng,
    String? description,
    bool? isOpen,
    String? openingTime,
    String? closingTime,
  });

  Future<Restaurant> updateRestaurant({
    required String id,
    required String name,
    required String address,
    double? locationLat,
    double? locationLng,
    String? description,
    bool? isOpen,
    String? openingTime,
    String? closingTime,
  });

  Future<void> deleteRestaurant(String id);

  Future<Restaurant> getRestaurantMenu(String id);

  Future<List<RestaurantReview>> getRestaurantReviews(String id);

  Future<Restaurant> getMyRestaurant();

  Future<Map<String, dynamic>> getRestaurantStatistics(String id);

  // Menu Categories
  Future<List<MenuCategory>> getMenuCategories({
    int? page,
    String? restaurantId,
  });

  Future<MenuCategory> getMenuCategory(String id);

  Future<MenuCategory> createMenuCategory({
    required String restaurantId,
    required String name,
    String? description,
    int? order,
  });

  Future<MenuCategory> updateMenuCategory({
    required String id,
    required String restaurantId,
    required String name,
    String? description,
    int? order,
  });

  Future<void> deleteMenuCategory(String id);

  // Menu Items
  Future<List<MenuItem>> getMenuItems({
    String? categoryId,
    bool? isAvailable,
    bool? isFeatured,
    int? page,
    String? restaurantId,
  });

  Future<MenuItem> getMenuItem(String id);

  Future<MenuItem> createMenuItem({
    required String restaurantId,
    String? categoryId,
    required String name,
    String? description,
    required double price,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
  });

  Future<MenuItem> updateMenuItem({
    required String id,
    required String restaurantId,
    String? categoryId,
    required String name,
    String? description,
    required double price,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
  });

  Future<void> deleteMenuItem(String id);

  // Reviews
  Future<List<RestaurantReview>> getReviews({
    int? page,
    int? rating,
    String? restaurantId,
    String? userId,
  });

  Future<RestaurantReview> getReview(String id);

  Future<RestaurantReview> createReview({
    required String restaurantId,
    required int rating,
    String? comment,
  });

  Future<RestaurantReview> updateReview({
    required String id,
    required String restaurantId,
    required int rating,
    String? comment,
  });

  Future<void> deleteReview(String id);
}

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantApiService _restaurantApiService;

  RestaurantRepositoryImpl(this._restaurantApiService);

  @override
  Future<List<RestaurantSummary>> getRestaurants({
    bool? isOpen,
    String? ordering,
    int? page,
    String? search,
  }) async {
    try {
      final paginatedDto = await _restaurantApiService.getRestaurants(
        isOpen: isOpen,
        ordering: ordering,
        page: page,
        search: search,
      );
      return paginatedDto.results
          .map((dto) => RestaurantMapper.fromListDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurants: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Restaurant> getRestaurantDetails(String id) async {
    try {
      final dto = await _restaurantApiService.getRestaurantDetails(id);
      return RestaurantMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurant details: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Restaurant> createRestaurant({
    required String name,
    required String address,
    double? locationLat,
    double? locationLng,
    String? description,
    bool? isOpen,
    String? openingTime,
    String? closingTime,
  }) async {
    try {
      final requestDto = RestaurantMapper.toRequestDto(
        name: name,
        address: address,
        locationLat: locationLat,
        locationLng: locationLng,
        description: description,
        isOpen: isOpen,
        openingTime: openingTime,
        closingTime: closingTime,
      );
      final dto = await _restaurantApiService.createRestaurant(requestDto);
      return RestaurantMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create restaurant: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Restaurant> updateRestaurant({
    required String id,
    required String name,
    required String address,
    double? locationLat,
    double? locationLng,
    String? description,
    bool? isOpen,
    String? openingTime,
    String? closingTime,
  }) async {
    try {
      final requestDto = RestaurantMapper.toRequestDto(
        name: name,
        address: address,
        locationLat: locationLat,
        locationLng: locationLng,
        description: description,
        isOpen: isOpen,
        openingTime: openingTime,
        closingTime: closingTime,
      );
      final dto = await _restaurantApiService.updateRestaurant(id, requestDto);
      return RestaurantMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update restaurant: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteRestaurant(String id) async {
    try {
      await _restaurantApiService.deleteRestaurant(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to delete restaurant: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Restaurant> getRestaurantMenu(String id) async {
    try {
      final dto = await _restaurantApiService.getRestaurantMenu(id);
      return RestaurantMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurant menu: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<RestaurantReview>> getRestaurantReviews(String id) async {
    try {
      final paginatedDto = await _restaurantApiService.getReviews(restaurant: id);
      return paginatedDto.results
          .map((dto) => RestaurantMapper.fromReviewDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurant reviews: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Restaurant> getMyRestaurant() async {
    try {
      final dto = await _restaurantApiService.getMyRestaurant();
      return RestaurantMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get my restaurant: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getRestaurantStatistics(String id) async {
    try {
      return await _restaurantApiService.getRestaurantStatistics(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurant statistics: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Menu Categories implementation
  @override
  Future<List<MenuCategory>> getMenuCategories({
    int? page,
    String? restaurantId,
  }) async {
    try {
      final paginatedDto = await _restaurantApiService.getMenuCategories(
        page: page,
        restaurant: restaurantId,
      );
      return paginatedDto.results
          .map((dto) => MenuCategoryMapper.fromDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get menu categories: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuCategory> getMenuCategory(String id) async {
    try {
      final dto = await _restaurantApiService.getMenuCategory(id);
      return MenuCategoryMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get menu category: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuCategory> createMenuCategory({
    required String restaurantId,
    required String name,
    String? description,
    int? order,
  }) async {
    try {
      final requestDto = MenuCategoryMapper.toRequestDto(
        restaurantId: restaurantId,
        name: name,
        description: description,
        order: order,
      );
      final dto = await _restaurantApiService.createMenuCategory(requestDto);
      return MenuCategoryMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create menu category: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuCategory> updateMenuCategory({
    required String id,
    required String restaurantId,
    required String name,
    String? description,
    int? order,
  }) async {
    try {
      final requestDto = MenuCategoryMapper.toRequestDto(
        restaurantId: restaurantId,
        name: name,
        description: description,
        order: order,
      );
      final dto = await _restaurantApiService.updateMenuCategory(id, requestDto);
      return MenuCategoryMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update menu category: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteMenuCategory(String id) async {
    try {
      await _restaurantApiService.deleteMenuCategory(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to delete menu category: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Menu Items implementation
  @override
  Future<List<MenuItem>> getMenuItems({
    String? categoryId,
    bool? isAvailable,
    bool? isFeatured,
    int? page,
    String? restaurantId,
  }) async {
    try {
      final paginatedDto = await _restaurantApiService.getMenuItems(
        category: categoryId,
        isAvailable: isAvailable,
        isFeatured: isFeatured,
        page: page,
        restaurant: restaurantId,
      );
      return paginatedDto.results
          .map((dto) => MenuItemMapper.fromDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get menu items: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuItem> getMenuItem(String id) async {
    try {
      final dto = await _restaurantApiService.getMenuItem(id);
      return MenuItemMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get menu item: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuItem> createMenuItem({
    required String restaurantId,
    String? categoryId,
    required String name,
    String? description,
    required double price,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
  }) async {
    try {
      final requestDto = MenuItemMapper.toRequestDto(
        restaurantId: restaurantId,
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
        isAvailable: isAvailable,
        isFeatured: isFeatured,
        preparationTimeMinutes: preparationTimeMinutes,
      );
      final dto = await _restaurantApiService.createMenuItem(requestDto);
      return MenuItemMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create menu item: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<MenuItem> updateMenuItem({
    required String id,
    required String restaurantId,
    String? categoryId,
    required String name,
    String? description,
    required double price,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
  }) async {
    try {
      final requestDto = MenuItemMapper.toRequestDto(
        restaurantId: restaurantId,
        categoryId: categoryId,
        name: name,
        description: description,
        price: price,
        isAvailable: isAvailable,
        isFeatured: isFeatured,
        preparationTimeMinutes: preparationTimeMinutes,
      );
      final dto = await _restaurantApiService.updateMenuItem(id, requestDto);
      return MenuItemMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update menu item: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteMenuItem(String id) async {
    try {
      await _restaurantApiService.deleteMenuItem(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to delete menu item: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Reviews implementation
  @override
  Future<List<RestaurantReview>> getReviews({
    int? page,
    int? rating,
    String? restaurantId,
    String? userId,
  }) async {
    try {
      final paginatedDto = await _restaurantApiService.getReviews(
        page: page,
        rating: rating != null ? Rating.fromInt(rating) : null,
        restaurant: restaurantId,
        user: userId,
      );
      return paginatedDto.results
          .map((dto) => RestaurantMapper.fromReviewDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get reviews: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<RestaurantReview> getReview(String id) async {
    try {
      final dto = await _restaurantApiService.getReview(id);
      return RestaurantMapper.fromReviewDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get review: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<RestaurantReview> createReview({
    required String restaurantId,
    required int rating,
    String? comment,
  }) async {
    try {
      final requestDto = RestaurantMapper.toReviewRequestDto(
        restaurantId: restaurantId,
        rating: rating,
        comment: comment,
      );
      final dto = await _restaurantApiService.createReview(requestDto);
      return RestaurantMapper.fromReviewDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create review: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<RestaurantReview> updateReview({
    required String id,
    required String restaurantId,
    required int rating,
    String? comment,
  }) async {
    try {
      final requestDto = RestaurantMapper.toReviewRequestDto(
        restaurantId: restaurantId,
        rating: rating,
        comment: comment,
      );
      final dto = await _restaurantApiService.updateReview(id, requestDto);
      return RestaurantMapper.fromReviewDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update review: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteReview(String id) async {
    try {
      await _restaurantApiService.deleteReview(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to delete review: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}
