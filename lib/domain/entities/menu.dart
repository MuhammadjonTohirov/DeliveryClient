class MenuCategory {
  final String id;
  final String restaurantId;
  final String name;
  final String? description;
  final int order;
  final List<MenuItem> items;

  const MenuCategory({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.description,
    required this.order,
    required this.items,
  });

  MenuCategory copyWith({
    String? id,
    String? restaurantId,
    String? name,
    String? description,
    int? order,
    List<MenuItem>? items,
  }) {
    return MenuCategory(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      description: description ?? this.description,
      order: order ?? this.order,
      items: items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class MenuItem {
  final String id;
  final String restaurantId;
  final String? categoryId;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final bool isAvailable;
  final bool isFeatured;
  final int? preparationTimeMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.isAvailable,
    required this.isFeatured,
    this.preparationTimeMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? categoryId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    bool? isFeatured,
    int? preparationTimeMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
      preparationTimeMinutes: preparationTimeMinutes ?? this.preparationTimeMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
