import 'enums.dart';
import 'order.dart';

class DriverLocation {
  final String id;
  final int driverId;
  final String driverName;
  final double latitude;
  final double longitude;
  final double? accuracy;
  final DateTime timestamp;

  const DriverLocation({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    required this.timestamp,
  });

  DriverLocation copyWith({
    String? id,
    int? driverId,
    String? driverName,
    double? latitude,
    double? longitude,
    double? accuracy,
    DateTime? timestamp,
  }) {
    return DriverLocation(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracy: accuracy ?? this.accuracy,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverLocation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DriverAvailability {
  final String id;
  final int driverId;
  final String driverName;
  final DriverAvailabilityStatus status;
  final DateTime lastUpdate;

  const DriverAvailability({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.status,
    required this.lastUpdate,
  });

  DriverAvailability copyWith({
    String? id,
    int? driverId,
    String? driverName,
    DriverAvailabilityStatus? status,
    DateTime? lastUpdate,
  }) {
    return DriverAvailability(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      status: status ?? this.status,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverAvailability &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DriverTask {
  final String id;
  final int driverId;
  final String driverName;
  final String orderId;
  final OrderSummary orderDetails;
  final DriverTaskStatus status;
  final DateTime assignedAt;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? completedAt;
  final String? notes;

  const DriverTask({
    required this.id,
    required this.driverId,
    required this.driverName,
    required this.orderId,
    required this.orderDetails,
    required this.status,
    required this.assignedAt,
    this.acceptedAt,
    this.pickedUpAt,
    this.completedAt,
    this.notes,
  });

  DriverTask copyWith({
    String? id,
    int? driverId,
    String? driverName,
    String? orderId,
    OrderSummary? orderDetails,
    DriverTaskStatus? status,
    DateTime? assignedAt,
    DateTime? acceptedAt,
    DateTime? pickedUpAt,
    DateTime? completedAt,
    String? notes,
  }) {
    return DriverTask(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      orderId: orderId ?? this.orderId,
      orderDetails: orderDetails ?? this.orderDetails,
      status: status ?? this.status,
      assignedAt: assignedAt ?? this.assignedAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverTask &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DriverEarning {
  final String id;
  final int driverId;
  final String driverName;
  final String? orderId;
  final String orderRefId;
  final double amount;
  final String description;
  final bool isBonus;
  final DateTime timestamp;

  const DriverEarning({
    required this.id,
    required this.driverId,
    required this.driverName,
    this.orderId,
    required this.orderRefId,
    required this.amount,
    required this.description,
    required this.isBonus,
    required this.timestamp,
  });

  DriverEarning copyWith({
    String? id,
    int? driverId,
    String? driverName,
    String? orderId,
    String? orderRefId,
    double? amount,
    String? description,
    bool? isBonus,
    DateTime? timestamp,
  }) {
    return DriverEarning(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      orderId: orderId ?? this.orderId,
      orderRefId: orderRefId ?? this.orderRefId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      isBonus: isBonus ?? this.isBonus,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverEarning &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
