import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/models/menu_item_model.dart';
import 'package:delivery_client/models/menu_category_model.dart';
import 'package:delivery_client/services/repositories/restaurant_repository.dart';
import 'package:flutter/material.dart'; // For TimeOfDay
import 'package:uuid/uuid.dart';

class MockRestaurantRepositoryImpl implements RestaurantRepository {
  final Uuid _uuid = const Uuid();
  late List<Restaurant> _mockRestaurants;
  late Map<String, List<MenuCategory>> _mockMenuCategories;
  late Map<String, List<MenuItem>> _mockMenuItems;

  MockRestaurantRepositoryImpl() {
    _generateMockData();
  }

  void _generateMockData() {
    // Mock Menu Items
    final menuItem1_1 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant1",
      categoryId: "cat1_1",
      name: "Margherita Pizza",
      description: "Classic cheese and tomato pizza",
      price: 12.99,
      imageUrl: "https://via.placeholder.com/150/FFC107/000000?Text=Pizza1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPopular: true,
      dietaryRestrictions: [const DietaryRestriction(id: "veg", name: "Vegetarian", iconUrl: "veg_icon")],
    );
    final menuItem1_2 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant1",
      categoryId: "cat1_1",
      name: "Pepperoni Pizza",
      description: "Pizza with pepperoni topping",
      price: 14.99,
      imageUrl: "https://via.placeholder.com/150/FFC107/000000?Text=Pizza2",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      spicyLevel: 1,
    );
    final menuItem1_3 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant1",
      categoryId: "cat1_2",
      name: "Spaghetti Carbonara",
      description: "Creamy pasta with bacon",
      price: 15.50,
      imageUrl: "https://via.placeholder.com/150/4CAF50/FFFFFF?Text=Pasta1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final menuItem1_4 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant1",
      categoryId: "cat1_3",
      name: "Tiramisu",
      description: "Classic Italian dessert",
      price: 7.00,
      imageUrl: "https://via.placeholder.com/150/E91E63/FFFFFF?Text=Dessert1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isFeatured: true,
    );

    final menuItem2_1 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant2",
      categoryId: "cat2_1",
      name: "Kung Pao Chicken",
      description: "Spicy stir-fried chicken",
      price: 13.75,
      imageUrl: "https://via.placeholder.com/150/F44336/FFFFFF?Text=Chicken1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      spicyLevel: 2,
      isPopular: true,
    );
    final menuItem2_2 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant2",
      categoryId: "cat2_1",
      name: "Sweet and Sour Pork",
      description: "Crispy pork with sweet and sour sauce",
      price: 14.25,
      imageUrl: "https://via.placeholder.com/150/F44336/FFFFFF?Text=Pork1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final menuItem2_3 = MenuItem(
      id: _uuid.v4(),
      restaurantId: "restaurant2",
      categoryId: "cat2_2",
      name: "Spring Rolls",
      description: "Vegetable spring rolls",
      price: 6.50,
      imageUrl: "https://via.placeholder.com/150/CDDC39/000000?Text=SpringRolls",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dietaryRestrictions: [const DietaryRestriction(id: "veg", name: "Vegetarian", iconUrl: "veg_icon")],
    );

    // Mock Menu Categories
    final category1_1 = MenuCategory(
      id: "cat1_1",
      restaurantId: "restaurant1",
      name: "Pizzas",
      order: 1,
      items: [menuItem1_1, menuItem1_2],
    );
    final category1_2 = MenuCategory(
      id: "cat1_2",
      restaurantId: "restaurant1",
      name: "Pastas",
      order: 2,
      items: [menuItem1_3],
    );
    final category1_3 = MenuCategory(
      id: "cat1_3",
      restaurantId: "restaurant1",
      name: "Desserts",
      order: 3,
      items: [menuItem1_4],
    );

    final category2_1 = MenuCategory(
      id: "cat2_1",
      restaurantId: "restaurant2",
      name: "Main Courses",
      order: 1,
      items: [menuItem2_1, menuItem2_2],
    );
    final category2_2 = MenuCategory(
      id: "cat2_2",
      restaurantId: "restaurant2",
      name: "Appetizers",
      order: 2,
      items: [menuItem2_3],
    );

    _mockMenuCategories = {
      "restaurant1": [category1_1, category1_2, category1_3],
      "restaurant2": [category2_1, category2_2],
    };

    _mockMenuItems = {
      "restaurant1": [menuItem1_1, menuItem1_2, menuItem1_3, menuItem1_4],
      "restaurant2": [menuItem2_1, menuItem2_2, menuItem2_3],
    };

    // Mock Restaurants
    _mockRestaurants = [
      Restaurant(
        id: "restaurant1",
        userId: "user1",
        name: "Italiano Delight",
        address: "123 Pizza Lane, Foodville",
        locationLat: 34.052235,
        locationLng: -118.243683,
        description:
            "Authentic Italian cuisine with a cozy ambiance. Perfect for family dinners and romantic evenings.",
        logoUrl: "https://via.placeholder.com/100/FF9800/FFFFFF?Text=ID",
        heroImageUrl: "https://via.placeholder.com/400x225/FF5722/FFFFFF?Text=Italiano+Delight+Hero",
        isOpen: true,
        openingTime: const TimeOfDay(hour: 11, minute: 0),
        closingTime: const TimeOfDay(hour: 22, minute: 0),
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        menuCategories: _mockMenuCategories["restaurant1"]!,
        menuItems: _mockMenuItems["restaurant1"]!,
        averageRating: 4.5,
        totalReviews: 150,
        ownerName: "Mario Rossi",
        cuisineType: "Italian",
        deliveryTimeEstimateMinutes: 30,
        deliveryFee: 2.99,
        distance: "1.5 km",
        promotionalBadges: ["Free Delivery", "20% Off Pasta"],
      ),
      Restaurant(
        id: "restaurant2",
        userId: "user2",
        name: "Dragon Wok",
        address: "456 Noodle Street, Chopstick City",
        locationLat: 34.058765,
        locationLng: -118.251234,
        description:
            "Savor the rich flavors of traditional Chinese cooking. From spicy Szechuan to delicate Cantonese dishes.",
        logoUrl: "https://via.placeholder.com/100/F44336/FFFFFF?Text=DW",
        heroImageUrl: "https://via.placeholder.com/400x225/E53935/FFFFFF?Text=Dragon+Wok+Hero",
        isOpen: true,
        openingTime: const TimeOfDay(hour: 10, minute: 30),
        closingTime: const TimeOfDay(hour: 21, minute: 30),
        createdAt: DateTime.now().subtract(const Duration(days: 200)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        menuCategories: _mockMenuCategories["restaurant2"]!,
        menuItems: _mockMenuItems["restaurant2"]!,
        averageRating: 4.2,
        totalReviews: 120,
        ownerName: "Li Wei",
        cuisineType: "Chinese",
        deliveryTimeEstimateMinutes: 25,
        deliveryFee: 1.99,
        distance: "0.8 km",
      ),
      Restaurant(
        id: "restaurant3",
        userId: "user3",
        name: "Taco Fiesta",
        address: "789 Burrito Blvd, Spice Town",
        locationLat: 34.041234,
        locationLng: -118.234567,
        description: "Experience the vibrant taste of Mexico! Fresh ingredients and bold flavors in every bite.",
        logoUrl: "https://via.placeholder.com/100/4CAF50/FFFFFF?Text=TF",
        heroImageUrl: "https://via.placeholder.com/400x225/388E3C/FFFFFF?Text=Taco+Fiesta+Hero",
        isOpen: false,
        openingTime: const TimeOfDay(hour: 12, minute: 0),
        closingTime: const TimeOfDay(hour: 20, minute: 0), // Currently closed
        createdAt: DateTime.now().subtract(const Duration(days: 50)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        menuCategories: [], // Populate if needed
        menuItems: [], // Populate if needed
        averageRating: 4.8,
        totalReviews: 200,
        ownerName: "Carlos Gomez",
        cuisineType: "Mexican",
        deliveryTimeEstimateMinutes: 35,
        deliveryFee: 3.49,
        distance: "2.2 km",
        promotionalBadges: ["Highly Rated"],
      ),
    ];
  }

  @override
  Future<List<Restaurant>> getRestaurants({bool? isOpen, String? searchTerm}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    List<Restaurant> results = List.from(_mockRestaurants);

    if (isOpen != null) {
      results = results.where((r) => r.isOpen == isOpen).toList();
    }
    if (searchTerm != null && searchTerm.isNotEmpty) {
      results = results
          .where(
            (r) =>
                r.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
                (r.cuisineType?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false),
          )
          .toList();
    }
    return results;
  }

  @override
  Future<Restaurant> getRestaurantDetails(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockRestaurants.firstWhere((r) => r.id == restaurantId);
    } catch (e) {
      throw Exception("Restaurant not found");
    }
  }

  @override
  Future<List<MenuItem>> getRestaurantMenu(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockMenuItems[restaurantId] ?? [];
  }

  @override
  Future<List<MenuCategory>> getRestaurantMenuCategories(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockMenuCategories[restaurantId] ?? [];
  }

  @override
  Future<List<MenuItem>> getMenuItemsByCategory(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    for (var catList in _mockMenuCategories.values) {
      for (var cat in catList) {
        if (cat.id == categoryId) {
          return cat.items;
        }
      }
    }
    return [];
  }

  @override
  Future<MenuItem> getMenuItemDetails(String menuItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    for (var itemList in _mockMenuItems.values) {
      try {
        return itemList.firstWhere((item) => item.id == menuItemId);
      } catch (e) {
        // Continue searching in other lists
      }
    }
    throw Exception("Menu item not found");
  }
}
