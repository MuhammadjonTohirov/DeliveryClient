// Corresponds to MenuItem and MenuItemRequest in OpenAPI spec

class MenuItemDto {
  final String id;
  final String restaurant; // restaurantId
  final String? category; // categoryId
  final String name;
  final String? description;
  final String price; // API sends as string
  final String? image; // URL string
  final bool? isAvailable;
  final bool? isFeatured;
  final int? preparationTime; // In minutes
  final String createdAt;
  final String updatedAt;

  MenuItemDto({
    required this.id,
    required this.restaurant,
    this.category,
    required this.name,
    this.description,
    required this.price,
    this.image,
    this.isAvailable,
    this.isFeatured,
    this.preparationTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MenuItemDto.fromJson(Map<String, dynamic> json) {
    return MenuItemDto(
      id: json['id'],
      restaurant: json['restaurant'],
      category: json['category'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toString(), // Ensure it's a string
      image: json['image'],
      isAvailable: json['is_available'],
      isFeatured: json['is_featured'],
      preparationTime: json['preparation_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class MenuItemRequestDto {
  final String restaurant; // restaurantId
  final String? category; // categoryId
  final String name;
  final String? description;
  final String price; // API expects string
  // final String? image; // For image uploads, this would be handled differently (e.g., MultipartFile)
  final bool? isAvailable;
  final bool? isFeatured;
  final int? preparationTime;

  MenuItemRequestDto({
    required this.restaurant,
    this.category,
    required this.name,
    this.description,
    required this.price,
    // this.image,
    this.isAvailable,
    this.isFeatured,
    this.preparationTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'restaurant': restaurant, 'name': name, 'price': price};
    if (category != null) data['category'] = category;
    if (description != null) data['description'] = description;
    // Image upload is more complex, typically not just a string in JSON for create/update
    if (isAvailable != null) data['is_available'] = isAvailable;
    if (isFeatured != null) data['is_featured'] = isFeatured;
    if (preparationTime != null) data['preparation_time'] = preparationTime;
    return data;
  }
}
