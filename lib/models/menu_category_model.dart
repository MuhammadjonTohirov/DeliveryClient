import 'package:flutter/foundation.dart';
import 'package:delivery_client/models/menu_item_model.dart';

@immutable
class MenuCategory {
  final String id;
  final String restaurantId;
  final String name;
  final String? description;
  final int order; // Display order
  final List<MenuItem> items;

  const MenuCategory({
    required this.id,
    required this.restaurantId,
    required this.name,
    this.description,
    this.order = 0,
    this.items = const [],
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
  String toString() {
    return 'MenuCategory(id: $id, name: $name, itemsCount: ${items.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
