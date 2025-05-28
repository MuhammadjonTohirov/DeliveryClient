import '../../domain/entities/order.dart';
import '../../domain/entities/enums.dart';
import '../network/dto/order_dto.dart';
import '../network/dto/base_dto.dart' as dto;

class OrderMapper {
  static Order fromDto(OrderDto dto) {
    return Order(
      id: dto.id,
      customerId: dto.customer,
      customerName: dto.customerName,
      restaurantId: dto.restaurant,
      restaurantName: dto.restaurantName,
      status: _mapOrderStatus(dto.status),
      deliveryAddress: dto.deliveryAddress,
      deliveryLat: dto.deliveryLat != null
          ? double.tryParse(dto.deliveryLat!)
          : null,
      deliveryLng: dto.deliveryLng != null
          ? double.tryParse(dto.deliveryLng!)
          : null,
      totalPrice: double.tryParse(dto.totalPrice) ?? 0.0,
      deliveryFee: double.tryParse(dto.deliveryFee) ?? 0.0,
      estimatedDeliveryTime: dto.estimatedDeliveryTime,
      notes: dto.notes,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      items: dto.items
          .map((itemDto) => _mapOrderItem(itemDto))
          .toList(),
      statusUpdates: dto.statusUpdates
          .map((updateDto) => _mapOrderStatusUpdate(updateDto))
          .toList(),
    );
  }

  static OrderSummary fromListDto(OrderListDto dto) {
    return OrderSummary(
      id: dto.id,
      customerName: dto.customerName,
      restaurantName: dto.restaurantName,
      status: _mapOrderStatus(dto.status),
      statusDisplay: dto.statusDisplay,
      deliveryAddress: dto.deliveryAddress,
      notes: dto.notes,
      totalPrice: double.tryParse(dto.totalPrice) ?? 0.0,
      createdAt: dto.createdAt,
      itemCount: int.tryParse(dto.itemCount) ?? 0,
      items: dto.items
          .map((itemDto) => _mapOrderItem(itemDto))
          .toList(),
    );
  }

  static OrderItem _mapOrderItem(OrderItemDto dto) {
    return OrderItem(
      id: dto.id,
      menuItemId: dto.menuItem,
      menuItemName: dto.menuItemName,
      quantity: dto.quantity,
      unitPrice: double.tryParse(dto.unitPrice) ?? 0.0,
      subtotal: double.tryParse(dto.subtotal) ?? 0.0,
      notes: dto.notes,
    );
  }

  static OrderStatusUpdate _mapOrderStatusUpdate(OrderStatusUpdateDto dto) {
    return OrderStatusUpdate(
      id: dto.id,
      status: _mapOrderStatus(dto.status),
      updatedById: dto.updatedBy,
      updatedByName: dto.updatedByName,
      notes: dto.notes,
      createdAt: dto.createdAt,
    );
  }

  static OrderStatus _mapOrderStatus(dto.OrderStatus status) {
    switch (status) {
      case dto.OrderStatus.placed:
        return OrderStatus.placed;
      case dto.OrderStatus.confirmed:
        return OrderStatus.confirmed;
      case dto.OrderStatus.preparing:
        return OrderStatus.preparing;
      case dto.OrderStatus.readyForPickup:
        return OrderStatus.readyForPickup;
      case dto.OrderStatus.pickedUp:
        return OrderStatus.pickedUp;
      case dto.OrderStatus.onTheWay:
        return OrderStatus.onTheWay;
      case dto.OrderStatus.delivered:
        return OrderStatus.delivered;
      case dto.OrderStatus.cancelled:
        return OrderStatus.cancelled;
    }
  }

  static dto.OrderStatus _mapOrderStatusToDto(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return dto.OrderStatus.placed;
      case OrderStatus.confirmed:
        return dto.OrderStatus.confirmed;
      case OrderStatus.preparing:
        return dto.OrderStatus.preparing;
      case OrderStatus.readyForPickup:
        return dto.OrderStatus.readyForPickup;
      case OrderStatus.pickedUp:
        return dto.OrderStatus.pickedUp;
      case OrderStatus.onTheWay:
        return dto.OrderStatus.onTheWay;
      case OrderStatus.delivered:
        return dto.OrderStatus.delivered;
      case OrderStatus.cancelled:
        return dto.OrderStatus.cancelled;
    }
  }

  static OrderRequestDto toRequestDto({
    required String restaurantId,
    required String deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    double? deliveryFee,
    DateTime? estimatedDeliveryTime,
    String? notes,
    required List<OrderItemRequest> items,
  }) {
    return OrderRequestDto(
      restaurant: restaurantId,
      deliveryAddress: deliveryAddress,
      deliveryLat: deliveryLat?.toString(),
      deliveryLng: deliveryLng?.toString(),
      deliveryFee: deliveryFee?.toString(),
      estimatedDeliveryTime: estimatedDeliveryTime,
      notes: notes,
      items: items.map((item) => OrderItemRequestDto(
        menuItem: item.menuItemId,
        quantity: item.quantity,
        notes: item.notes,
      )).toList(),
    );
  }

  static OrderUpdateRequestDto toUpdateDto({
    required OrderStatus status,
    String? statusNote,
  }) {
    return OrderUpdateRequestDto(
      status: _mapOrderStatusToDto(status),
      statusNote: statusNote,
    );
  }
}

// Helper class for creating orders
class OrderItemRequest {
  final String menuItemId;
  final int quantity;
  final String? notes;

  const OrderItemRequest({
    required this.menuItemId,
    required this.quantity,
    this.notes,
  });
}
