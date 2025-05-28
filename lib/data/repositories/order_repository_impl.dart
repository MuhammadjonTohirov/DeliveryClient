import '../../domain/entities/order.dart';
import '../../domain/entities/enums.dart';
import '../../core/network/services/order_api_service.dart';
import '../../core/mappers/order_mapper.dart';
import '../../core/errors/network_exception.dart';

abstract class OrderRepository {
  Future<List<OrderSummary>> getOrders({
    String? ordering,
    int? page,
  });

  Future<Order> getOrderDetails(String id);

  Future<Order> createOrder({
    required String restaurantId,
    required String deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    double? deliveryFee,
    DateTime? estimatedDeliveryTime,
    String? notes,
    required List<OrderItemRequest> items,
  });

  Future<void> updateOrderStatus({
    required String id,
    required OrderStatus status,
    String? statusNote,
  });

  Future<void> deleteOrder(String id);

  Future<Order> cancelOrder(String id);

  Future<Order> getOrderHistory(String id);

  Future<Order> markOrderReadyForPickup(String id);

  Future<Order> markOrderAsPreparing(String id);

  Future<Order> restaurantAcceptOrder(String id);

  Future<Order> restaurantRejectOrder(String id);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderApiService _orderApiService;

  OrderRepositoryImpl(this._orderApiService);

  @override
  Future<List<OrderSummary>> getOrders({
    String? ordering,
    int? page,
  }) async {
    try {
      final paginatedDto = await _orderApiService.getOrders(
        ordering: ordering,
        page: page,
      );
      return paginatedDto.results
          .map((dto) => OrderMapper.fromListDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get orders: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> getOrderDetails(String id) async {
    try {
      final dto = await _orderApiService.getOrderDetails(id);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get order details: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> createOrder({
    required String restaurantId,
    required String deliveryAddress,
    double? deliveryLat,
    double? deliveryLng,
    double? deliveryFee,
    DateTime? estimatedDeliveryTime,
    String? notes,
    required List<OrderItemRequest> items,
  }) async {
    try {
      final requestDto = OrderMapper.toRequestDto(
        restaurantId: restaurantId,
        deliveryAddress: deliveryAddress,
        deliveryLat: deliveryLat,
        deliveryLng: deliveryLng,
        deliveryFee: deliveryFee,
        estimatedDeliveryTime: estimatedDeliveryTime,
        notes: notes,
        items: items,
      );
      final dto = await _orderApiService.createOrder(requestDto);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create order: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> updateOrderStatus({
    required String id,
    required OrderStatus status,
    String? statusNote,
  }) async {
    try {
      final requestDto = OrderMapper.toUpdateDto(
        status: status,
        statusNote: statusNote,
      );
      await _orderApiService.updateOrder(id, requestDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update order status: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> deleteOrder(String id) async {
    try {
      await _orderApiService.deleteOrder(id);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to delete order: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> cancelOrder(String id) async {
    try {
      final dto = await _orderApiService.cancelOrder(id);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to cancel order: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> getOrderHistory(String id) async {
    try {
      final dto = await _orderApiService.getOrderHistory(id);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get order history: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> markOrderReadyForPickup(String id) async {
    try {
      final dto = await _orderApiService.markOrderReadyForPickup(id);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to mark order ready for pickup: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> markOrderAsPreparing(String id) async {
    try {
      final dto = await _orderApiService.markOrderAsPreparing(id);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to mark order as preparing: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> restaurantAcceptOrder(String id) async {
    try {
      final dto = await _orderApiService.restaurantAction(id, accept: true);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to accept order: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<Order> restaurantRejectOrder(String id) async {
    try {
      final dto = await _orderApiService.restaurantAction(id, accept: false);
      return OrderMapper.fromDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to reject order: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}
