import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/models/menu_item_model.dart';
import 'package:delivery_client/models/menu_category_model.dart';
// import 'package:delivery_client/models/restaurant_review_model.dart'; // To be created

// Abstract class defining the contract for restaurant-related data operations
abstract class RestaurantRepository {
  Future<List<Restaurant>> getRestaurants({
    bool? isOpen,
    String? searchTerm,
    // Add other filters like cuisine, rating, delivery_time, price_range, distance
  });
  Future<Restaurant> getRestaurantDetails(String restaurantId);
  Future<List<MenuItem>> getRestaurantMenu(String restaurantId); // Or get full Restaurant object with menu
  Future<List<MenuCategory>> getRestaurantMenuCategories(String restaurantId);
  Future<List<MenuItem>> getMenuItemsByCategory(String categoryId);
  Future<MenuItem> getMenuItemDetails(String menuItemId);

  // Future<List<RestaurantReview>> getRestaurantReviews(String restaurantId);
  // Future<RestaurantReview> submitRestaurantReview(String restaurantId, RestaurantReview review);

  // For restaurant owners (if applicable for this client app, or a separate app)
  // Future<Restaurant> createRestaurant(Restaurant restaurant);
  // Future<Restaurant> updateRestaurant(Restaurant restaurant);
  // Future<MenuCategory> createMenuCategory(MenuCategory category);
  // Future<MenuCategory> updateMenuCategory(MenuCategory category);
  // Future<void> deleteMenuCategory(String categoryId);
  // Future<MenuItem> createMenuItem(MenuItem item);
  // Future<MenuItem> updateMenuItem(MenuItem item);
  // Future<void> deleteMenuItem(String itemId);
}
