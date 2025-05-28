import 'enums.dart';

class OrderItem {
  final String id;
  final String menuItemId;
  final String menuItemName;
  final int quantity;
  final double unitPrice;
  final double subtotal;
  final String? notes;

  const OrderItem({
    required this.id,
    required this.menuItemId,
    required this.menuItemName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    this.notes,
  });

  OrderItem copyWith({
    String? id,
    String? menuItemId,
    String? menuItemName,
    int? quantity,
    double? unitPrice,
    double? subtotal,
    String? notes,
  }) {
    return OrderItem(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      menuItemName: menuItemName ?? this.menuItemName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      subtotal: subtotal ?? this.subtotal,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OrderStatusUpdate {
  final String id;
  final OrderStatus status;
  final String? updatedById;
  final String updatedByName;
  final String? notes;
  final DateTime createdAt;

  const OrderStatusUpdate({
    required this.id,
    required this.status,
    this.updatedById,
    required this.updatedByName,
    this.notes,
    required this.createdAt,
  });

  OrderStatusUpdate copyWith({
    String? id,
    OrderStatus? status,
    String? updatedById,
    String? updatedByName,
    String? notes,
    DateTime? createdAt,
  }) {
    return OrderStatusUpdate(
      id: id ?? this.id,
      status: status ?? this.status,
      updatedById: updatedById ?? this.updatedById,
      updatedByName: updatedByName ?? this.updatedByName,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusUpdate &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Order {
  final String id;
  final String customerId;
  final String customerName;
  final String restaurantId;
  final String restaurantName;
  final OrderStatus status;
  final String deliveryAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final double totalPrice;
  final double deliveryFee;
  final DateTime? estimatedDeliveryTime;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> items;
  final List<OrderStatusUpdate> statusUpdates;

  const Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.restaurantId,
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

  Order copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? restaurantId,
    String? restaurantName,
    OrderStatus? status,
    String? deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    double? totalPrice,
    double? deliveryFee,
    DateTime? estimatedDeliveryTime,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItem>? items,
    List<OrderStatusUpdate>? statusUpdates,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLat: deliveryLat ?? this.deliveryLat,
      deliveryLng: deliveryLng ?? this.deliveryLng,
      totalPrice: totalPrice ?? this.totalPrice,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      estimatedDeliveryTime: estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
      statusUpdates: statusUpdates ?? this.statusUpdates,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OrderSummary {
  final String id;
  final String customerName;
  final String restaurantName;
  final OrderStatus status;
  final String statusDisplay;
  final String deliveryAddress;
  final String? notes;
  final double totalPrice;
  final DateTime createdAt;
  final int itemCount;
  final List<OrderItem> items;

  const OrderSummary({
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

  OrderSummary copyWith({
    String? id,
    String? customerName,
    String? restaurantName,
    OrderStatus? status,
    String? statusDisplay,
    String? deliveryAddress,
    String? notes,
    double? totalPrice,
    DateTime? createdAt,
    int? itemCount,
    List<OrderItem>? items,
  }) {
    return OrderSummary(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      restaurantName: restaurantName ?? this.restaurantName,
      status: status ?? this.status,
      statusDisplay: statusDisplay ?? this.statusDisplay,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      itemCount: itemCount ?? this.itemCount,
      items: items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderSummary &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
