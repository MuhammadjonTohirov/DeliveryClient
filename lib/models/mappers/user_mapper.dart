import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/models/dtos/user_dto.dart';
import 'package:delivery_client/models/mappers/customer_profile_mapper.dart';
// Mappers for DriverProfile and RestaurantProfile will be needed if those are included

class UserMapper {
  static User fromDto(UserDto dto) {
    return User(
      id: dto.id,
      email: dto.email,
      phone: dto.phone,
      fullName: dto.fullName,
      role: roleFromString(dto.role), // Convert string role to enum
      isActive: dto.isActive,
      dateJoined: DateTime.tryParse(dto.dateJoined) ?? DateTime.now(), // Handle potential parse error
      customerProfile: dto.customerProfile != null ? CustomerProfileMapper.fromDto(dto.customerProfile!) : null,
      // driverProfile: dto.driverProfile != null
      //     ? DriverProfileMapper.fromDto(dto.driverProfile!)
      //     : null,
      // restaurantProfile: dto.restaurantProfile != null
      //     ? RestaurantProfileMapper.fromDto(dto.restaurantProfile!)
      //     : null,
    );
  }

  static UserRegistrationRequestDto toRegistrationRequestDto(User model, String password, String passwordConfirm) {
    return UserRegistrationRequestDto(
      email: model.email,
      phone: model.phone,
      fullName: model.fullName,
      password: password,
      passwordConfirm: passwordConfirm,
      role: roleToString(model.role), // Convert enum role to string
      customerProfile: model.customerProfile != null
          ? CustomerProfileMapper.toRequestDto(model.customerProfile!)
          : null,
      // driverProfile: model.driverProfile != null
      //     ? DriverProfileMapper.toRequestDto(model.driverProfile!)
      //     : null,
      // restaurantProfile: model.restaurantProfile != null
      //     ? RestaurantProfileMapper.toRequestDto(model.restaurantProfile!)
      //     : null,
    );
  }

  static UserUpdateRequestDto toUpdateRequestDto(User model) {
    return UserUpdateRequestDto(
      email: model.email,
      phone: model.phone,
      fullName: model.fullName,
      role: roleToString(model.role),
      customerProfile: model.customerProfile != null
          ? CustomerProfileMapper.toRequestDto(model.customerProfile!)
          : null,
      // driverProfile: model.driverProfile != null
      //     ? DriverProfileMapper.toRequestDto(model.driverProfile!)
      //     : null,
      // restaurantProfile: model.restaurantProfile != null
      //     ? RestaurantProfileMapper.toRequestDto(model.restaurantProfile!)
      //     : null,
    );
  }
}
