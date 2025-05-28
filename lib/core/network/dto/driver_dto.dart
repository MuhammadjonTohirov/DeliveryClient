import 'base_dto.dart';
import 'order_dto.dart';

class DriverLocationDto {
  final String id;
  final int driver;
  final String driverName;
  final String latitude;
  final String longitude;
  final double? accuracy;
  final DateTime timestamp;

  const DriverLocationDto({
    required this.id,
    required this.driver,
    required this.driverName,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.timestamp,
  });

  factory DriverLocationDto.fromJson(Map<String, dynamic> json) {
    return DriverLocationDto(
      id: json['id'] as String,
      driver: json['driver'] as int,
      driverName: json['driver_name'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      accuracy: json['accuracy'] as double?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver,
      'driver_name': driverName,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class DriverLocationRequestDto {
  final int driver;
  final String latitude;
  final String longitude;
  final double? accuracy;

  const DriverLocationRequestDto({
    required this.driver,
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

  Map<String, dynamic> toJson() {
    return {
      'driver': driver,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
    };
  }
}

class DriverAvailabilityDto {
  final String id;
  final int driver;
  final String driverName;
  final DriverAvailabilityStatus status;
  final DateTime lastUpdate;

  const DriverAvailabilityDto({
    required this.id,
    required this.driver,
    required this.driverName,
    required this.status,
    required this.lastUpdate,
  });

  factory DriverAvailabilityDto.fromJson(Map<String, dynamic> json) {
    return DriverAvailabilityDto(
      id: json['id'] as String,
      driver: json['driver'] as int,
      driverName: json['driver_name'] as String,
      status: DriverAvailabilityStatus.fromString(json['status'] as String),
      lastUpdate: DateTime.parse(json['last_update'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver,
      'driver_name': driverName,
      'status': status.value,
      'last_update': lastUpdate.toIso8601String(),
    };
  }
}

class DriverAvailabilityRequestDto {
  final DriverAvailabilityStatus status;

  const DriverAvailabilityRequestDto({required this.status});

  Map<String, dynamic> toJson() {
    return {
      'status': status.value,
    };
  }
}

class DriverTaskDto {
  final String id;
  final int driver;
  final String driverName;
  final String order;
  final OrderListDto orderDetails;
  final DriverTaskStatus status;
  final DateTime assignedAt;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? completedAt;
  final String? notes;

  const DriverTaskDto({
    required this.id,
    required this.driver,
    required this.driverName,
    required this.order,
    required this.orderDetails,
    required this.status,
    required this.assignedAt,
    this.acceptedAt,
    this.pickedUpAt,
    this.completedAt,
    this.notes,
  });

  factory DriverTaskDto.fromJson(Map<String, dynamic> json) {
    return DriverTaskDto(
      id: json['id'] as String,
      driver: json['driver'] as int,
      driverName: json['driver_name'] as String,
      order: json['order'] as String,
      orderDetails: OrderListDto.fromJson(
          json['order_details'] as Map<String, dynamic>),
      status: DriverTaskStatus.fromString(json['status'] as String),
      assignedAt: DateTime.parse(json['assigned_at'] as String),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'] as String)
          : null,
      pickedUpAt: json['picked_up_at'] != null
          ? DateTime.parse(json['picked_up_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver,
      'driver_name': driverName,
      'order': order,
      'order_details': orderDetails.toJson(),
      'status': status.value,
      'assigned_at': assignedAt.toIso8601String(),
      'accepted_at': acceptedAt?.toIso8601String(),
      'picked_up_at': pickedUpAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'notes': notes,
    };
  }
}

class DriverTaskRequestDto {
  final DriverTaskStatus status;
  final String? notes;

  const DriverTaskRequestDto({
    required this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status.value,
      'notes': notes,
    };
  }
}

class DriverEarningDto {
  final String id;
  final int driver;
  final String driverName;
  final String? order;
  final String orderId;
  final String amount;
  final String description;
  final bool isBonus;
  final DateTime timestamp;

  const DriverEarningDto({
    required this.id,
    required this.driver,
    required this.driverName,
    this.order,
    required this.orderId,
    required this.amount,
    required this.description,
    required this.isBonus,
    required this.timestamp,
  });

  factory DriverEarningDto.fromJson(Map<String, dynamic> json) {
    return DriverEarningDto(
      id: json['id'] as String,
      driver: json['driver'] as int,
      driverName: json['driver_name'] as String,
      order: json['order'] as String?,
      orderId: json['order_id'] as String,
      amount: json['amount'] as String,
      description: json['description'] as String,
      isBonus: json['is_bonus'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver': driver,
      'driver_name': driverName,
      'order': order,
      'order_id': orderId,
      'amount': amount,
      'description': description,
      'is_bonus': isBonus,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
