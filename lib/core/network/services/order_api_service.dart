import '../api_client.dart';
import '../dto/base_dto.dart';
import '../dto/order_dto.dart';

class OrderApiService {
  final ApiClient _apiClient;

  OrderApiService(this._apiClient);

  // Get list of orders based on user role
  Future<PaginatedResponseDto<OrderListDto>> getOrders({
    String? ordering,
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (ordering != null) queryParams['ordering'] = ordering;
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/orders/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, OrderListDto.fromJson);
  }

  // Get order details
  Future<OrderDto> getOrderDetails(String id) async {
    final response = await _apiClient.get('/orders/$id/');
    return OrderDto.fromJson(response);
  }

  // Create a new order (Customer only)
  Future<OrderDto> createOrder(OrderRequestDto request) async {
    final response = await _apiClient.post(
      '/orders/',
      body: request.toJson(),
    );
    return OrderDto.fromJson(response);
  }

  // Update order details
  Future<OrderUpdateDto> updateOrder(
      String id, OrderUpdateRequestDto request) async {
    final response = await _apiClient.put(
      '/orders/$id/',
      body: request.toJson(),
    );
    return OrderUpdateDto.fromJson(response);
  }

  // Partially update order details
  Future<OrderUpdateDto> partialUpdateOrder(
      String id, OrderUpdateRequestDto request) async {
    final response = await _apiClient.patch(
      '/orders/$id/',
      body: request.toJson(),
    );
    return OrderUpdateDto.fromJson(response);
  }

  // Delete order
  Future<void> deleteOrder(String id) async {
    await _apiClient.delete('/orders/$id/');
  }

  // Cancel order (Customer only)
  Future<OrderDto> cancelOrder(String id) async {
    final response = await _apiClient.post('/orders/$id/cancel/');
    return OrderDto.fromJson(response);
  }

  // Get order status history
  Future<OrderDto> getOrderHistory(String id) async {
    final response = await _apiClient.get('/orders/$id/history/');
    return OrderDto.fromJson(response);
  }

  // Mark order as ready for pickup (Restaurant owner only)
  Future<OrderDto> markOrderReadyForPickup(String id) async {
    final response = await _apiClient.post('/orders/$id/mark_ready_for_pickup/');
    return OrderDto.fromJson(response);
  }

  // Mark order as preparing (Restaurant owner only)
  Future<OrderDto> markOrderAsPreparing(String id) async {
    final response = await _apiClient.post('/orders/$id/preparing/');
    return OrderDto.fromJson(response);
  }

  // Restaurant accept/reject order (Restaurant owner only)
  Future<OrderDto> restaurantAction(String id, {required bool accept}) async {
    final body = {
      'action': accept ? 'accept' : 'reject',
    };
    final response = await _apiClient.post(
      '/orders/$id/restaurant_action/',
      body: body,
    );
    return OrderDto.fromJson(response);
  }
}
