import '../api_client.dart';
import '../dto/auth_dto.dart';
import '../dto/base_dto.dart';

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  // Register a new user
  Future<UserDto> register(UserRegistrationRequestDto request) async {
    final response = await _apiClient.post(
      '/users/register/',
      body: request.toJson(),
    );
    return UserDto.fromJson(response);
  }

  // Login user
  Future<TokenResponseDto> login(LoginRequestDto request) async {
    final response = await _apiClient.post(
      '/users/token/',
      body: request.toJson(),
    );
    return TokenResponseDto.fromJson(response);
  }

  // Refresh access token
  Future<TokenRefreshResponseDto> refreshToken(TokenRefreshRequestDto request) async {
    final response = await _apiClient.post(
      '/users/token/refresh/',
      body: request.toJson(),
    );
    return TokenRefreshResponseDto.fromJson(response);
  }

  // Logout user (blacklist refresh token)
  Future<void> logout() async {
    await _apiClient.post('/users/logout/');
  }

  // Get user profile
  Future<UserDto> getUserProfile() async {
    final response = await _apiClient.get('/users/profile/');
    return UserDto.fromJson(response);
  }

  // Update user profile
  Future<UserDto> updateUserProfile(UserUpdateRequestDto request) async {
    final response = await _apiClient.put(
      '/users/profile/',
      body: request.toJson(),
    );
    return UserDto.fromJson(response);
  }

  // Partially update user profile
  Future<UserDto> partialUpdateUserProfile(UserUpdateRequestDto request) async {
    final response = await _apiClient.patch(
      '/users/profile/',
      body: request.toJson(),
    );
    return UserDto.fromJson(response);
  }

  // Change password
  Future<void> changePassword(ChangePasswordRequestDto request) async {
    await _apiClient.post(
      '/users/change-password/',
      body: request.toJson(),
    );
  }

  // Get all customers (Admin only)
  Future<PaginatedResponseDto<UserDto>> getCustomers({
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/users/customers/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, UserDto.fromJson);
  }

  // Get all drivers (Admin only)
  Future<PaginatedResponseDto<UserDto>> getDrivers({
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/users/drivers/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, UserDto.fromJson);
  }

  // Get all restaurant owners (Admin only)
  Future<PaginatedResponseDto<UserDto>> getRestaurantOwners({
    int? page,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();

    final response = await _apiClient.get(
      '/users/restaurant-owners/',
      queryParameters: queryParams,
    );
    return PaginatedResponseDto.fromJson(response, UserDto.fromJson);
  }
}
