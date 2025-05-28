import '../../domain/entities/user.dart';
import '../../domain/entities/enums.dart';
import '../network/dto/auth_dto.dart';
import '../network/dto/base_dto.dart' as dto;

class UserMapper {
  static User fromDto(UserDto dto) {
    return User(
      id: dto.id,
      email: dto.email,
      phone: dto.phone,
      fullName: dto.fullName,
      role: _mapUserRole(dto.role),
      isActive: dto.isActive,
      dateJoined: dto.dateJoined,
      customerProfile: dto.customerProfile != null
          ? _mapCustomerProfile(dto.customerProfile!)
          : null,
      driverProfile: dto.driverProfile != null
          ? _mapDriverProfile(dto.driverProfile!)
          : null,
      restaurantProfile: dto.restaurantProfile != null
          ? _mapRestaurantProfile(dto.restaurantProfile!)
          : null,
    );
  }

  static UserDto toDto(User entity) {
    return UserDto(
      id: entity.id,
      email: entity.email,
      phone: entity.phone,
      fullName: entity.fullName,
      role: _mapUserRoleToDto(entity.role),
      isActive: entity.isActive,
      dateJoined: entity.dateJoined,
      customerProfile: entity.customerProfile != null
          ? _mapCustomerProfileToDto(entity.customerProfile!)
          : null,
      driverProfile: entity.driverProfile != null
          ? _mapDriverProfileToDto(entity.driverProfile!)
          : null,
      restaurantProfile: entity.restaurantProfile != null
          ? _mapRestaurantProfileToDto(entity.restaurantProfile!)
          : null,
    );
  }

  static AuthTokens fromTokenDto(TokenResponseDto dto) {
    return AuthTokens(
      accessToken: dto.access,
      refreshToken: dto.refresh,
    );
  }

  static UserRole _mapUserRole(dto.UserRole role) {
    switch (role) {
      case dto.UserRole.customer:
        return UserRole.customer;
      case dto.UserRole.driver:
        return UserRole.driver;
      case dto.UserRole.restaurant:
        return UserRole.restaurant;
      case dto.UserRole.admin:
        return UserRole.admin;
    }
  }

  static dto.UserRole _mapUserRoleToDto(UserRole role) {
    switch (role) {
      case UserRole.customer:
        return dto.UserRole.customer;
      case UserRole.driver:
        return dto.UserRole.driver;
      case UserRole.restaurant:
        return dto.UserRole.restaurant;
      case UserRole.admin:
        return dto.UserRole.admin;
    }
  }

  static CustomerProfile _mapCustomerProfile(CustomerProfileDto dto) {
    return CustomerProfile(
      defaultAddress: dto.defaultAddress,
      defaultLocationLat: dto.defaultLocationLat != null
          ? double.tryParse(dto.defaultLocationLat!)
          : null,
      defaultLocationLng: dto.defaultLocationLng != null
          ? double.tryParse(dto.defaultLocationLng!)
          : null,
    );
  }

  static CustomerProfileDto _mapCustomerProfileToDto(CustomerProfile entity) {
    return CustomerProfileDto(
      defaultAddress: entity.defaultAddress,
      defaultLocationLat: entity.defaultLocationLat?.toString(),
      defaultLocationLng: entity.defaultLocationLng?.toString(),
    );
  }

  static DriverProfile _mapDriverProfile(DriverProfileDto dto) {
    return DriverProfile(
      vehicleType: dto.vehicleType,
      licenseNumber: dto.licenseNumber,
    );
  }

  static DriverProfileDto _mapDriverProfileToDto(DriverProfile entity) {
    return DriverProfileDto(
      vehicleType: entity.vehicleType,
      licenseNumber: entity.licenseNumber,
    );
  }

  static RestaurantProfile _mapRestaurantProfile(RestaurantProfileDto dto) {
    return RestaurantProfile(
      businessName: dto.businessName,
      businessAddress: dto.businessAddress,
      businessRegistrationNumber: dto.businessRegistrationNumber,
    );
  }

  static RestaurantProfileDto _mapRestaurantProfileToDto(RestaurantProfile entity) {
    return RestaurantProfileDto(
      businessName: entity.businessName,
      businessAddress: entity.businessAddress,
      businessRegistrationNumber: entity.businessRegistrationNumber,
    );
  }

  static UserRegistrationRequestDto toRegistrationDto({
    required String email,
    String? phone,
    required String fullName,
    required String password,
    required String passwordConfirm,
    required UserRole role,
    CustomerProfile? customerProfile,
    DriverProfile? driverProfile,
    RestaurantProfile? restaurantProfile,
  }) {
    return UserRegistrationRequestDto(
      email: email,
      phone: phone,
      fullName: fullName,
      password: password,
      passwordConfirm: passwordConfirm,
      role: _mapUserRoleToDto(role),
      customerProfile: customerProfile != null
          ? _mapCustomerProfileToDto(customerProfile)
          : null,
      driverProfile: driverProfile != null
          ? _mapDriverProfileToDto(driverProfile)
          : null,
      restaurantProfile: restaurantProfile != null
          ? _mapRestaurantProfileToDto(restaurantProfile)
          : null,
    );
  }

  static UserUpdateRequestDto toUpdateDto(User entity) {
    return UserUpdateRequestDto(
      email: entity.email,
      phone: entity.phone,
      fullName: entity.fullName,
      role: _mapUserRoleToDto(entity.role),
      customerProfile: entity.customerProfile != null
          ? _mapCustomerProfileToDto(entity.customerProfile!)
          : null,
      driverProfile: entity.driverProfile != null
          ? _mapDriverProfileToDto(entity.driverProfile!)
          : null,
      restaurantProfile: entity.restaurantProfile != null
          ? _mapRestaurantProfileToDto(entity.restaurantProfile!)
          : null,
    );
  }

  static LoginRequestDto toLoginDto({
    required String email,
    required String password,
  }) {
    return LoginRequestDto(
      email: email,
      password: password,
    );
  }

  static ChangePasswordRequestDto toChangePasswordDto({
    required String oldPassword,
    required String newPassword,
  }) {
    return ChangePasswordRequestDto(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
