// Base DTO classes and common DTOs

class PaginatedResponseDto<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  const PaginatedResponseDto({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PaginatedResponseDto.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponseDto<T>(
      count: json['count'] ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
              ?.map((item) => fromJsonT(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map(toJsonT).toList(),
    };
  }
}

// Enums
enum UserRole {
  customer('CUSTOMER'),
  driver('DRIVER'),
  restaurant('RESTAURANT'),
  admin('ADMIN');

  const UserRole(this.value);
  final String value;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.customer,
    );
  }
}

enum OrderStatus {
  placed('PLACED'),
  confirmed('CONFIRMED'),
  preparing('PREPARING'),
  readyForPickup('READY_FOR_PICKUP'),
  pickedUp('PICKED_UP'),
  onTheWay('ON_THE_WAY'),
  delivered('DELIVERED'),
  cancelled('CANCELLED');

  const OrderStatus(this.value);
  final String value;

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => OrderStatus.placed,
    );
  }
}

enum DriverAvailabilityStatus {
  available('AVAILABLE'),
  busy('BUSY'),
  offline('OFFLINE');

  const DriverAvailabilityStatus(this.value);
  final String value;

  static DriverAvailabilityStatus fromString(String value) {
    return DriverAvailabilityStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => DriverAvailabilityStatus.offline,
    );
  }
}

enum DriverTaskStatus {
  pending('PENDING'),
  accepted('ACCEPTED'),
  rejected('REJECTED'),
  pickedUp('PICKED_UP'),
  delivered('DELIVERED'),
  cancelled('CANCELLED');

  const DriverTaskStatus(this.value);
  final String value;

  static DriverTaskStatus fromString(String value) {
    return DriverTaskStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => DriverTaskStatus.pending,
    );
  }
}

enum Rating {
  one(1),
  two(2),
  three(3),
  four(4),
  five(5);

  const Rating(this.value);
  final int value;

  static Rating fromInt(int value) {
    return Rating.values.firstWhere(
      (rating) => rating.value == value,
      orElse: () => Rating.one,
    );
  }
}
