import 'base_dto.dart';
import 'menu_dto.dart';

class OrderItemDto {
  final String id;
  final String menuItem;
  final String menuItemName;
  final int quantity;
  final String unitPrice;
  final String subtotal;
  final String? notes;

  const OrderItemDto({
    required this.id,
    required this.menuItem,
    required this.menuItemName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    this.notes,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDto(
      id: json['id'] as String,
      menuItem: json['menu_item'] as String,
      menuItemName: json['menu_item_name'] as String,
      quantity: json['quantity'] as int,
      unitPrice: json['unit_price'] as String,
      subtotal: json['subtotal'] as String,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menu_item': menuItem,
      'menu_item_name': menuItemName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
      'notes': notes,
    };
  }
}

class OrderItemRequestDto {
  final String menuItem;
  final int quantity;
  final String? notes;

  const OrderItemRequestDto({
    required this.menuItem,
    required this.quantity,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'menu_item': menuItem,
      'quantity': quantity,
      'notes': notes,
    };
  }
}

class OrderStatusUpdateDto {
  final String id;
  final OrderStatus status;
  final String? updatedBy;
  final String updatedByName;
  final String? notes;
  final DateTime createdAt;

  const OrderStatusUpdateDto({
    required this.id,
    required this.status,
    this.updatedBy,
    required this.updatedByName,
    this.notes,
    required this.createdAt,
  });

  factory OrderStatusUpdateDto.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdateDto(
      id: json['id'] as String,
      status: OrderStatus.fromString(json['status'] as String),
      updatedBy: json['updated_by'] as String?,
      updatedByName: json['updated_by_name'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.value,
      'updated_by': updatedBy,
      'updated_by_name': updatedByName,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class OrderDto {
  final String id;
  final String customer;
  final String customerName;
  final String restaurant;
  final String restaurantName;
  final OrderStatus status;
  final String deliveryAddress;
  final String? deliveryLat;
  final String? deliveryLng;
  final String totalPrice;
  final String deliveryFee;
  final DateTime? estimatedDeliveryTime;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemDto> items;
  final List<OrderStatusUpdateDto> statusUpdates;

  const OrderDto({
    required this.id,
    required this.customer,
    required this.customerName,
    required this.restaurant,
    required this.restaurantName,
    required this.status,
    required this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
    required this.totalPrice,
    required this.deliveryFee,
    this.estimatedDeliveryTime,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    required this.statusUpdates,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      id: json['id'] as String,
      customer: json['customer'] as String,
      customerName: json['customer_name'] as String,
      restaurant: json['restaurant'] as String,
      restaurantName: json['restaurant_name'] as String,
      status: OrderStatus.fromString(json['status'] as String),
      deliveryAddress: json['delivery_address'] as String,
      deliveryLat: json['delivery_lat'] as String?,
      deliveryLng: json['delivery_lng'] as String?,
      totalPrice: json['total_price'] as String,
      deliveryFee: json['delivery_fee'] as String,
      estimatedDeliveryTime: json['estimated_delivery_time'] != null
          ? DateTime.parse(json['estimated_delivery_time'] as String)
          : null,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      statusUpdates: (json['status_updates'] as List<dynamic>)
          .map((update) =>
              OrderStatusUpdateDto.fromJson(update as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'customer_name': customerName,
      'restaurant': restaurant,
      'restaurant_name': restaurantName,
      'status': status.value,
      'delivery_address': deliveryAddress,
      'delivery_lat': deliveryLat,
      'delivery_lng': deliveryLng,
      'total_price': totalPrice,
      'delivery_fee': deliveryFee,
      'estimated_delivery_time': estimatedDeliveryTime?.toIso8601String(),
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'status_updates':
          statusUpdates.map((update) => update.toJson()).toList(),
    };
  }
}

class OrderListDto {
  final String id;
  final String customerName;
  final String restaurantName;
  final OrderStatus status;
  final String statusDisplay;
  final String deliveryAddress;
  final String? notes;
  final String totalPrice;
  final DateTime createdAt;
  final String itemCount;
  final List<OrderItemDto> items;

  const OrderListDto({
    required this.id,
    required this.customerName,
    required this.restaurantName,
    required this.status,
    required this.statusDisplay,
    required this.deliveryAddress,
    this.notes,
    required this.totalPrice,
    required this.createdAt,
    required this.itemCount,
    required this.items,
  });

  factory OrderListDto.fromJson(Map<String, dynamic> json) {
    return OrderListDto(
      id: json['id'] as String,
      customerName: json['customer_name'] as String,
      restaurantName: json['restaurant_name'] as String,
      status: OrderStatus.fromString(json['status'] as String),
      statusDisplay: json['status_display'] as String,
      deliveryAddress: json['delivery_address'] as String,
      notes: json['notes'] as String?,
      totalPrice: json['total_price'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      itemCount: json['item_count'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItemDto.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'restaurant_name': restaurantName,
      'status': status.value,
      'status_display': statusDisplay,
      'delivery_address': deliveryAddress,
      'notes': notes,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'item_count': itemCount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderRequestDto {
  final String restaurant;
  final OrderStatus? status;
  final String deliveryAddress;
  final String? deliveryLat;
  final String? deliveryLng;
  final String? deliveryFee;
  final DateTime? estimatedDeliveryTime;
  final String? notes;
  final List<OrderItemRequestDto> items;

  const OrderRequestDto({
    required this.restaurant,
    this.status,
    required this.deliveryAddress,
    this.deliveryLat,
    this.deliveryLng,
    this.deliveryFee,
    this.estimatedDeliveryTime,
    this.notes,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurant': restaurant,
      'status': status?.value,
      'delivery_address': deliveryAddress,
      'delivery_lat': deliveryLat,
      'delivery_lng': deliveryLng,
      'delivery_fee': deliveryFee,
      'estimated_delivery_time': estimatedDeliveryTime?.toIso8601String(),
      'notes': notes,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderUpdateDto {
  final OrderStatus status;

  const OrderUpdateDto({required this.status});

  factory OrderUpdateDto.fromJson(Map<String, dynamic> json) {
    return OrderUpdateDto(
      status: OrderStatus.fromString(json['status'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.value,
    };
  }
}

class OrderUpdateRequestDto {
  final OrderStatus status;
  final String? statusNote;

  const OrderUpdateRequestDto({
    required this.status,
    this.statusNote,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status.value,
      'status_note': statusNote,
    };
  }
}
