import '../../domain/entities/user.dart';
import '../../domain/entities/enums.dart';
import '../../core/network/services/auth_api_service.dart';
import '../../core/mappers/user_mapper.dart';
import '../../core/errors/network_exception.dart';
import '../../core/network/dto/auth_dto.dart';

abstract class AuthRepository {
  Future<User> register({
    required String email,
    String? phone,
    required String fullName,
    required String password,
    required String passwordConfirm,
    required UserRole role,
    CustomerProfile? customerProfile,
    DriverProfile? driverProfile,
    RestaurantProfile? restaurantProfile,
  });

  Future<AuthTokens> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<String> refreshToken(String refreshToken);

  Future<User> getUserProfile();

  Future<User> updateUserProfile(User user);

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<List<User>> getCustomers({int? page});

  Future<List<User>> getDrivers({int? page});

  Future<List<User>> getRestaurantOwners({int? page});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);

  @override
  Future<User> register({
    required String email,
    String? phone,
    required String fullName,
    required String password,
    required String passwordConfirm,
    required UserRole role,
    CustomerProfile? customerProfile,
    DriverProfile? driverProfile,
    RestaurantProfile? restaurantProfile,
  }) async {
    try {
      final requestDto = UserMapper.toRegistrationDto(
        email: email,
        phone: phone,
        fullName: fullName,
        password: password,
        passwordConfirm: passwordConfirm,
        role: role,
        customerProfile: customerProfile,
        driverProfile: driverProfile,
        restaurantProfile: restaurantProfile,
      );

      final userDto = await _authApiService.register(requestDto);
      return UserMapper.fromDto(userDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to register user: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    try {
      final requestDto = UserMapper.toLoginDto(
        email: email,
        password: password,
      );

      final tokenDto = await _authApiService.login(requestDto);
      return UserMapper.fromTokenDto(tokenDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to login: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _authApiService.logout();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to logout: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    try {
      final requestDto = TokenRefreshRequestDto(refresh: refreshToken);
      final responseDto = await _authApiService.refreshToken(requestDto);
      return responseDto.access;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to refresh token: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<User> getUserProfile() async {
    try {
      final userDto = await _authApiService.getUserProfile();
      return UserMapper.fromDto(userDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get user profile: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<User> updateUserProfile(User user) async {
    try {
      final requestDto = UserMapper.toUpdateDto(user);
      final userDto = await _authApiService.updateUserProfile(requestDto);
      return UserMapper.fromDto(userDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to update user profile: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final requestDto = UserMapper.toChangePasswordDto(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      await _authApiService.changePassword(requestDto);
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to change password: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<User>> getCustomers({int? page}) async {
    try {
      final paginatedDto = await _authApiService.getCustomers(page: page);
      return paginatedDto.results
          .map((userDto) => UserMapper.fromDto(userDto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get customers: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<User>> getDrivers({int? page}) async {
    try {
      final paginatedDto = await _authApiService.getDrivers(page: page);
      return paginatedDto.results
          .map((userDto) => UserMapper.fromDto(userDto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get drivers: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  @override
  Future<List<User>> getRestaurantOwners({int? page}) async {
    try {
      final paginatedDto = await _authApiService.getRestaurantOwners(page: page);
      return paginatedDto.results
          .map((userDto) => UserMapper.fromDto(userDto))
          .toList();
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException(
        message: 'Failed to get restaurant owners: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}
