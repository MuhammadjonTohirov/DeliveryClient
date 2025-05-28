import '../api_client.dart';
import '../dto/base_dto.dart';
import '../dto/driver_dto.dart';

class DriverApiService {
  final ApiClient _apiClient;

  DriverApiService(this._apiClient);

  // --- Driver Availability ---

  // Get list of driver availability
  Future<PaginatedResponseDto<DriverAvailabilityDto>> getDriverAvailability({
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/drivers/availability/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, DriverAvailabilityDto.fromJson);
  }

  // Get driver availability status
  Future<DriverAvailabilityDto> getDriverAvailabilityStatus(String id) async {
    final response = await _apiClient.get('/drivers/availability/$id/');
    return DriverAvailabilityDto.fromJson(response);
  }

  // Update driver availability status
  Future<DriverAvailabilityDto> updateDriverAvailability(
      String id, DriverAvailabilityRequestDto request) async {
    final response = await _apiClient.put(
      '/drivers/availability/$id/',
      body: request.toJson(),
    );
    return DriverAvailabilityDto.fromJson(response);
  }

  // Partially update driver availability
  Future<DriverAvailabilityDto> partialUpdateDriverAvailability(
      String id, DriverAvailabilityRequestDto request) async {
    final response = await _apiClient.patch(
      '/drivers/availability/$id/',
      body: request.toJson(),
    );
    return DriverAvailabilityDto.fromJson(response);
  }

  // Get current driver's availability status
  Future<DriverAvailabilityDto> getMyAvailability() async {
    final response = await _apiClient.get('/drivers/availability/me/');
    return DriverAvailabilityDto.fromJson(response);
  }

  // --- Driver Locations ---

  // Get list of driver location updates
  Future<PaginatedResponseDto<DriverLocationDto>> getDriverLocations({
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/drivers/locations/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, DriverLocationDto.fromJson);
  }

  // Create a new location update (Driver only)
  Future<DriverLocationDto> createLocationUpdate(
      DriverLocationRequestDto request) async {
    final response = await _apiClient.post(
      '/drivers/locations/',
      body: request.toJson(),
    );
    return DriverLocationDto.fromJson(response);
  }

  // Get details of a specific location update
  Future<DriverLocationDto> getLocationDetails(String id) async {
    final response = await _apiClient.get('/drivers/locations/$id/');
    return DriverLocationDto.fromJson(response);
  }

  // Get the latest location for the current driver
  Future<DriverLocationDto> getLatestLocation() async {
    final response = await _apiClient.get('/drivers/locations/latest/');
    return DriverLocationDto.fromJson(response);
  }

  // --- Driver Tasks ---

  // Get list of all tasks for a driver
  Future<PaginatedResponseDto<DriverTaskDto>> getDriverTasks({
    String? ordering,
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (ordering != null) queryParams['ordering'] = ordering;
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/drivers/tasks/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, DriverTaskDto.fromJson);
  }

  // Get details of a specific task
  Future<DriverTaskDto> getTaskDetails(String id) async {
    final response = await _apiClient.get('/drivers/tasks/$id/');
    return DriverTaskDto.fromJson(response);
  }

  // Update task status (Driver only)
  Future<DriverTaskDto> updateTask(
      String id, DriverTaskRequestDto request) async {
    final response = await _apiClient.put(
      '/drivers/tasks/$id/',
      body: request.toJson(),
    );
    return DriverTaskDto.fromJson(response);
  }

  // Partially update task status (Driver only)
  Future<DriverTaskDto> partialUpdateTask(
      String id, DriverTaskRequestDto request) async {
    final response = await _apiClient.patch(
      '/drivers/tasks/$id/',
      body: request.toJson(),
    );
    return DriverTaskDto.fromJson(response);
  }

  // Get the driver's current active task
  Future<DriverTaskDto> getActiveTask() async {
    final response = await _apiClient.get('/drivers/tasks/active/');
    return DriverTaskDto.fromJson(response);
  }

  // --- Driver Earnings ---

  // Get list of all earnings for a driver
  Future<PaginatedResponseDto<DriverEarningDto>> getDriverEarnings({
    String? ordering,
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (ordering != null) queryParams['ordering'] = ordering;
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/drivers/earnings/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, DriverEarningDto.fromJson);
  }

  // Get details of a specific earning
  Future<DriverEarningDto> getEarningDetails(String id) async {
    final response = await _apiClient.get('/drivers/earnings/$id/');
    return DriverEarningDto.fromJson(response);
  }

  // Get earnings summary for a specified period
  Future<DriverEarningDto> getEarningsSummary() async {
    final response = await _apiClient.get('/drivers/earnings/summary/');
    return DriverEarningDto.fromJson(response);
  }
}
