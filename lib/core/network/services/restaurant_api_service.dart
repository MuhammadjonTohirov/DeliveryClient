import '../api_client.dart';
import '../dto/base_dto.dart';
import '../dto/restaurant_dto.dart';
import '../dto/menu_dto.dart';

class RestaurantApiService {
  final ApiClient _apiClient;

  RestaurantApiService(this._apiClient);

  // Get list of all restaurants
  Future<PaginatedResponseDto<RestaurantListDto>> getRestaurants({
    bool? isOpen,
    String? ordering,
    int? page,
    String? search,
  }) async {
    final queryParams = <String, String>{};
    if (isOpen != null) queryParams['is_open'] = isOpen.toString();
    if (ordering != null) queryParams['ordering'] = ordering;
    if (page != null) queryParams['page'] = page.toString();
    if (search != null) queryParams['search'] = search;

    final response = await _apiClient.get(
      '/restaurants/list/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, RestaurantListDto.fromJson);
  }

  // Get restaurant details
  Future<RestaurantDto> getRestaurantDetails(String id) async {
    final response = await _apiClient.get('/restaurants/list/$id/');
    return RestaurantDto.fromJson(response);
  }

  // Create a new restaurant (Restaurant user only)
  Future<RestaurantDto> createRestaurant(RestaurantRequestDto request) async {
    final response = await _apiClient.post(
      '/restaurants/list/',
      body: request.toJson(),
    );
    return RestaurantDto.fromJson(response);
  }

  // Update restaurant (Restaurant owner only)
  Future<RestaurantDto> updateRestaurant(
      String id, RestaurantRequestDto request) async {
    final response = await _apiClient.put(
      '/restaurants/list/$id/',
      body: request.toJson(),
    );
    return RestaurantDto.fromJson(response);
  }

  // Partially update restaurant (Restaurant owner only)
  Future<RestaurantDto> partialUpdateRestaurant(
      String id, RestaurantRequestDto request) async {
    final response = await _apiClient.patch(
      '/restaurants/list/$id/',
      body: request.toJson(),
    );
    return RestaurantDto.fromJson(response);
  }

  // Delete restaurant
  Future<void> deleteRestaurant(String id) async {
    await _apiClient.delete('/restaurants/list/$id/');
  }

  // Get restaurant menu
  Future<RestaurantDto> getRestaurantMenu(String id) async {
    final response = await _apiClient.get('/restaurants/list/$id/menu/');
    return RestaurantDto.fromJson(response);
  }

  // Get restaurant reviews
  Future<RestaurantDto> getRestaurantReviews(String id) async {
    final response = await _apiClient.get('/restaurants/list/$id/reviews/');
    return RestaurantDto.fromJson(response);
  }

  // Get my restaurant (for restaurant owners)
  Future<RestaurantDto> getMyRestaurant() async {
    final response = await _apiClient.get('/restaurants/list/mine/');
    return RestaurantDto.fromJson(response);
  }

  // Get restaurant statistics
  Future<Map<String, dynamic>> getRestaurantStatistics(String id) async {
    final response = await _apiClient.get('/restaurants/statistics/$id/get/');
    return response;
  }

  // --- Menu Categories ---

  // Get menu categories
  Future<PaginatedResponseDto<MenuCategoryDto>> getMenuCategories({
    int? page,
    String? restaurant,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();
    if (restaurant != null) queryParams['restaurant'] = restaurant;

    final response = await _apiClient.get(
      '/restaurants/categories/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, MenuCategoryDto.fromJson);
  }

  // Get menu category details
  Future<MenuCategoryDto> getMenuCategory(String id) async {
    final response = await _apiClient.get('/restaurants/categories/$id/');
    return MenuCategoryDto.fromJson(response);
  }

  // Create menu category (Restaurant owner only)
  Future<MenuCategoryDto> createMenuCategory(
      MenuCategoryRequestDto request) async {
    final response = await _apiClient.post(
      '/restaurants/categories/',
      body: request.toJson(),
    );
    return MenuCategoryDto.fromJson(response);
  }

  // Update menu category (Restaurant owner only)
  Future<MenuCategoryDto> updateMenuCategory(
      String id, MenuCategoryRequestDto request) async {
    final response = await _apiClient.put(
      '/restaurants/categories/$id/',
      body: request.toJson(),
    );
    return MenuCategoryDto.fromJson(response);
  }

  // Partially update menu category (Restaurant owner only)
  Future<MenuCategoryDto> partialUpdateMenuCategory(
      String id, MenuCategoryRequestDto request) async {
    final response = await _apiClient.patch(
      '/restaurants/categories/$id/',
      body: request.toJson(),
    );
    return MenuCategoryDto.fromJson(response);
  }

  // Delete menu category (Restaurant owner only)
  Future<void> deleteMenuCategory(String id) async {
    await _apiClient.delete('/restaurants/categories/$id/');
  }

  // --- Menu Items ---

  // Get menu items
  Future<PaginatedResponseDto<MenuItemDto>> getMenuItems({
    String? category,
    bool? isAvailable,
    bool? isFeatured,
    int? page,
    String? restaurant,
  }) async {
    final queryParams = <String, String>{};
    if (category != null) queryParams['category'] = category;
    if (isAvailable != null) queryParams['is_available'] = isAvailable.toString();
    if (isFeatured != null) queryParams['is_featured'] = isFeatured.toString();
    if (page != null) queryParams['page'] = page.toString();
    if (restaurant != null) queryParams['restaurant'] = restaurant;

    final response = await _apiClient.get(
      '/restaurants/menu-items/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, MenuItemDto.fromJson);
  }

  // Get menu item details
  Future<MenuItemDto> getMenuItem(String id) async {
    final response = await _apiClient.get('/restaurants/menu-items/$id/');
    return MenuItemDto.fromJson(response);
  }

  // Create menu item (Restaurant owner only)
  Future<MenuItemDto> createMenuItem(MenuItemRequestDto request) async {
    final response = await _apiClient.post(
      '/restaurants/menu-items/',
      body: request.toJson(),
    );
    return MenuItemDto.fromJson(response);
  }

  // Update menu item (Restaurant owner only)
  Future<MenuItemDto> updateMenuItem(
      String id, MenuItemRequestDto request) async {
    final response = await _apiClient.put(
      '/restaurants/menu-items/$id/',
      body: request.toJson(),
    );
    return MenuItemDto.fromJson(response);
  }

  // Partially update menu item (Restaurant owner only)
  Future<MenuItemDto> partialUpdateMenuItem(
      String id, MenuItemRequestDto request) async {
    final response = await _apiClient.patch(
      '/restaurants/menu-items/$id/',
      body: request.toJson(),
    );
    return MenuItemDto.fromJson(response);
  }

  // Delete menu item (Restaurant owner only)
  Future<void> deleteMenuItem(String id) async {
    await _apiClient.delete('/restaurants/menu-items/$id/');
  }

  // --- Reviews ---

  // Get reviews
  Future<PaginatedResponseDto<RestaurantReviewDto>> getReviews({
    int? page,
    Rating? rating,
    String? restaurant,
    String? user,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();
    if (rating != null) queryParams['rating'] = rating.value.toString();
    if (restaurant != null) queryParams['restaurant'] = restaurant;
    if (user != null) queryParams['user'] = user;

    final response = await _apiClient.get(
      '/restaurants/reviews/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, RestaurantReviewDto.fromJson);
  }

  // Get review details
  Future<RestaurantReviewDto> getReview(String id) async {
    final response = await _apiClient.get('/restaurants/reviews/$id/');
    return RestaurantReviewDto.fromJson(response);
  }

  // Create review (Customer only)
  Future<RestaurantReviewDto> createReview(
      RestaurantReviewRequestDto request) async {
    final response = await _apiClient.post(
      '/restaurants/reviews/',
      body: request.toJson(),
    );
    return RestaurantReviewDto.fromJson(response);
  }

  // Update review (Customer only)
  Future<RestaurantReviewDto> updateReview(
      String id, RestaurantReviewRequestDto request) async {
    final response = await _apiClient.put(
      '/restaurants/reviews/$id/',
      body: request.toJson(),
    );
    return RestaurantReviewDto.fromJson(response);
  }

  // Partially update review (Customer only)
  Future<RestaurantReviewDto> partialUpdateReview(
      String id, RestaurantReviewRequestDto request) async {
    final response = await _apiClient.patch(
      '/restaurants/reviews/$id/',
      body: request.toJson(),
    );
    return RestaurantReviewDto.fromJson(response);
  }

  // Delete review (Customer only)
  Future<void> deleteReview(String id) async {
    await _apiClient.delete('/restaurants/reviews/$id/');
  }
}
