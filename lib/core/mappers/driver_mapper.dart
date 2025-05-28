import '../../domain/entities/driver.dart';
import '../../domain/entities/enums.dart';
import '../network/dto/driver_dto.dart';
import '../network/dto/base_dto.dart' as dto;
import 'order_mapper.dart';

class DriverMapper {
  static DriverLocation fromLocationDto(DriverLocationDto dto) {
    return DriverLocation(
      id: dto.id,
      driverId: dto.driver,
      driverName: dto.driverName,
      latitude: double.tryParse(dto.latitude) ?? 0.0,
      longitude: double.tryParse(dto.longitude) ?? 0.0,
      accuracy: dto.accuracy,
      timestamp: dto.timestamp,
    );
  }

  static DriverAvailability fromAvailabilityDto(DriverAvailabilityDto dto) {
    return DriverAvailability(
      id: dto.id,
      driverId: dto.driver,
      driverName: dto.driverName,
      status: _mapAvailabilityStatus(dto.status),
      lastUpdate: dto.lastUpdate,
    );
  }

  static DriverTask fromTaskDto(DriverTaskDto dto) {
    return DriverTask(
      id: dto.id,
      driverId: dto.driver,
      driverName: dto.driverName,
      orderId: dto.order,
      orderDetails: OrderMapper.fromListDto(dto.orderDetails),
      status: _mapTaskStatus(dto.status),
      assignedAt: dto.assignedAt,
      acceptedAt: dto.acceptedAt,
      pickedUpAt: dto.pickedUpAt,
      completedAt: dto.completedAt,
      notes: dto.notes,
    );
  }

  static DriverEarning fromEarningDto(DriverEarningDto dto) {
    return DriverEarning(
      id: dto.id,
      driverId: dto.driver,
      driverName: dto.driverName,
      orderId: dto.order,
      orderRefId: dto.orderId,
      amount: double.tryParse(dto.amount) ?? 0.0,
      description: dto.description,
      isBonus: dto.isBonus,
      timestamp: dto.timestamp,
    );
  }

  static DriverAvailabilityStatus _mapAvailabilityStatus(dto.DriverAvailabilityStatus status) {
    switch (status) {
      case dto.DriverAvailabilityStatus.available:
        return DriverAvailabilityStatus.available;
      case dto.DriverAvailabilityStatus.busy:
        return DriverAvailabilityStatus.busy;
      case dto.DriverAvailabilityStatus.offline:
        return DriverAvailabilityStatus.offline;
    }
  }

  static dto.DriverAvailabilityStatus _mapAvailabilityStatusToDto(DriverAvailabilityStatus status) {
    switch (status) {
      case DriverAvailabilityStatus.available:
        return dto.DriverAvailabilityStatus.available;
      case DriverAvailabilityStatus.busy:
        return dto.DriverAvailabilityStatus.busy;
      case DriverAvailabilityStatus.offline:
        return dto.DriverAvailabilityStatus.offline;
    }
  }

  static DriverTaskStatus _mapTaskStatus(dto.DriverTaskStatus status) {
    switch (status) {
      case dto.DriverTaskStatus.pending:
        return DriverTaskStatus.pending;
      case dto.DriverTaskStatus.accepted:
        return DriverTaskStatus.accepted;
      case dto.DriverTaskStatus.rejected:
        return DriverTaskStatus.rejected;
      case dto.DriverTaskStatus.pickedUp:
        return DriverTaskStatus.pickedUp;
      case dto.DriverTaskStatus.delivered:
        return DriverTaskStatus.delivered;
      case dto.DriverTaskStatus.cancelled:
        return DriverTaskStatus.cancelled;
    }
  }

  static dto.DriverTaskStatus _mapTaskStatusToDto(DriverTaskStatus status) {
    switch (status) {
      case DriverTaskStatus.pending:
        return dto.DriverTaskStatus.pending;
      case DriverTaskStatus.accepted:
        return dto.DriverTaskStatus.accepted;
      case DriverTaskStatus.rejected:
        return dto.DriverTaskStatus.rejected;
      case DriverTaskStatus.pickedUp:
        return dto.DriverTaskStatus.pickedUp;
      case DriverTaskStatus.delivered:
        return dto.DriverTaskStatus.delivered;
      case DriverTaskStatus.cancelled:
        return dto.DriverTaskStatus.cancelled;
    }
  }

  static DriverLocationRequestDto toLocationRequestDto({
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) {
    return DriverLocationRequestDto(
      driver: driverId,
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      accuracy: accuracy,
    );
  }

  static DriverAvailabilityRequestDto toAvailabilityRequestDto({
    required DriverAvailabilityStatus status,
  }) {
    return DriverAvailabilityRequestDto(
      status: _mapAvailabilityStatusToDto(status),
    );
  }

  static DriverTaskRequestDto toTaskRequestDto({
    required DriverTaskStatus status,
    String? notes,
  }) {
    return DriverTaskRequestDto(
      status: _mapTaskStatusToDto(status),
      notes: notes,
    );
  }
}
