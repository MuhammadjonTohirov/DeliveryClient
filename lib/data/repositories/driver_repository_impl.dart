import '../../domain/entities/driver.dart';
import '../../domain/entities/enums.dart';
import '../../core/network/services/driver_api_service.dart';
import '../../core/mappers/driver_mapper.dart';
import '../../core/errors/network_exception.dart';

abstract class DriverRepository {
  // Driver Availability
  Future<List<DriverAvailability>> getDriverAvailability({int? page});
  Future<DriverAvailability> getDriverAvailabilityStatus(String id);
  Future<DriverAvailability> updateDriverAvailability({
    required String id,
    required DriverAvailabilityStatus status,
  });
  Future<DriverAvailability> getMyAvailability();

  // Driver Locations
  Future<List<DriverLocation>> getDriverLocations({int? page});
  Future<DriverLocation> createLocationUpdate({
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
  });
  Future<DriverLocation> getLocationDetails(String id);
  Future<DriverLocation> getLatestLocation();

  // Driver Tasks
  Future<List<DriverTask>> getDriverTasks({
    String? ordering,
    int? page,
  });
  Future<DriverTask> getTaskDetails(String id);
  Future<DriverTask> updateTask({
    required String id,
    required DriverTaskStatus status,
    String? notes,
  });
  Future<DriverTask> getActiveTask();

  // Driver Earnings
  Future<List<DriverEarning>> getDriverEarnings({
    String? ordering,
    int? page,
  });
  Future<DriverEarning> getEarningDetails(String id);
  Future<DriverEarning> getEarningsSummary();
}

class DriverRepositoryImpl implements DriverRepository {
  final DriverApiService _driverApiService;

  DriverRepositoryImpl(this._driverApiService);

  // Driver Availability implementation
  @override
  Future<List<DriverAvailability>> getDriverAvailability({int? page}) async {
    try {
      final paginatedDto = await _driverApiService.getDriverAvailability(page: page);
      return paginatedDto.results
          .map((dto) => DriverMapper.fromAvailabilityDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get driver availability: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverAvailability> getDriverAvailabilityStatus(String id) async {
    try {
      final dto = await _driverApiService.getDriverAvailabilityStatus(id);
      return DriverMapper.fromAvailabilityDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get driver availability status: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverAvailability> updateDriverAvailability({
    required String id,
    required DriverAvailabilityStatus status,
  }) async {
    try {
      final requestDto = DriverMapper.toAvailabilityRequestDto(status: status);
      final dto = await _driverApiService.updateDriverAvailability(id, requestDto);
      return DriverMapper.fromAvailabilityDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update driver availability: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverAvailability> getMyAvailability() async {
    try {
      final dto = await _driverApiService.getMyAvailability();
      return DriverMapper.fromAvailabilityDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get my availability: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Driver Locations implementation
  @override
  Future<List<DriverLocation>> getDriverLocations({int? page}) async {
    try {
      final paginatedDto = await _driverApiService.getDriverLocations(page: page);
      return paginatedDto.results
          .map((dto) => DriverMapper.fromLocationDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get driver locations: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverLocation> createLocationUpdate({
    required int driverId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    try {
      final requestDto = DriverMapper.toLocationRequestDto(
        driverId: driverId,
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );
      final dto = await _driverApiService.createLocationUpdate(requestDto);
      return DriverMapper.fromLocationDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to create location update: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverLocation> getLocationDetails(String id) async {
    try {
      final dto = await _driverApiService.getLocationDetails(id);
      return DriverMapper.fromLocationDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get location details: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverLocation> getLatestLocation() async {
    try {
      final dto = await _driverApiService.getLatestLocation();
      return DriverMapper.fromLocationDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get latest location: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Driver Tasks implementation
  @override
  Future<List<DriverTask>> getDriverTasks({
    String? ordering,
    int? page,
  }) async {
    try {
      final paginatedDto = await _driverApiService.getDriverTasks(
        ordering: ordering,
        page: page,
      );
      return paginatedDto.results
          .map((dto) => DriverMapper.fromTaskDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get driver tasks: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverTask> getTaskDetails(String id) async {
    try {
      final dto = await _driverApiService.getTaskDetails(id);
      return DriverMapper.fromTaskDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get task details: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverTask> updateTask({
    required String id,
    required DriverTaskStatus status,
    String? notes,
  }) async {
    try {
      final requestDto = DriverMapper.toTaskRequestDto(
        status: status,
        notes: notes,
      );
      final dto = await _driverApiService.updateTask(id, requestDto);
      return DriverMapper.fromTaskDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update task: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverTask> getActiveTask() async {
    try {
      final dto = await _driverApiService.getActiveTask();
      return DriverMapper.fromTaskDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get active task: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // Driver Earnings implementation
  @override
  Future<List<DriverEarning>> getDriverEarnings({
    String? ordering,
    int? page,
  }) async {
    try {
      final paginatedDto = await _driverApiService.getDriverEarnings(
        ordering: ordering,
        page: page,
      );
      return paginatedDto.results
          .map((dto) => DriverMapper.fromEarningDto(dto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get driver earnings: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverEarning> getEarningDetails(String id) async {
    try {
      final dto = await _driverApiService.getEarningDetails(id);
      return DriverMapper.fromEarningDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get earning details: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<DriverEarning> getEarningsSummary() async {
    try {
      final dto = await _driverApiService.getEarningsSummary();
      return DriverMapper.fromEarningDto(dto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get earnings summary: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}
