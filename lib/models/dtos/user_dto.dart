import 'package:delivery_client/models/dtos/customer_profile_dto.dart';
// import 'package:delivery_client/models/dtos/driver_profile_dto.dart'; // To be created
// import 'package:delivery_client/models/dtos/restaurant_profile_dto.dart'; // To be created

// Corresponds to User in OpenAPI spec (response model)
class UserDto {
  final String id;
  final String email;
  final String? phone;
  final String fullName;
  final String role; // API sends role as string e.g. "CUSTOMER"
  final bool isActive;
  final String dateJoined; // API sends as string (date-time)
  final CustomerProfileDto? customerProfile;
  // final DriverProfileDto? driverProfile;
  // final RestaurantProfileDto? restaurantProfile;

  UserDto({
    required this.id,
    required this.email,
    this.phone,
    required this.fullName,
    required this.role,
    required this.isActive,
    required this.dateJoined,
    this.customerProfile,
    // this.driverProfile,
    // this.restaurantProfile,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      fullName: json['full_name'],
      role: json['role'],
      isActive: json['is_active'] ?? false,
      dateJoined: json['date_joined'],
      customerProfile: json['customer_profile'] != null ? CustomerProfileDto.fromJson(json['customer_profile']) : null,
      // driverProfile: json['driver_profile'] != null
      //     ? DriverProfileDto.fromJson(json['driver_profile'])
      //     : null,
      // restaurantProfile: json['restaurant_profile'] != null
      //     ? RestaurantProfileDto.fromJson(json['restaurant_profile'])
      //     : null,
    );
  }
}

// Corresponds to UserRegistrationRequest in OpenAPI spec
class UserRegistrationRequestDto {
  final String email;
  final String? phone;
  final String fullName;
  final String password;
  final String passwordConfirm;
  final String role; // e.g., "CUSTOMER"
  final CustomerProfileRequestDto? customerProfile;
  // final DriverProfileRequestDto? driverProfile;
  // final RestaurantProfileRequestDto? restaurantProfile;

  UserRegistrationRequestDto({
    required this.email,
    this.phone,
    required this.fullName,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    this.customerProfile,
    // this.driverProfile,
    // this.restaurantProfile,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'full_name': fullName,
      'password': password,
      'password_confirm': passwordConfirm,
      'role': role,
    };
    if (phone != null) {
      data['phone'] = phone;
    }
    if (customerProfile != null) {
      data['customer_profile'] = customerProfile!.toJson();
    }
    // if (driverProfile != null) {
    //   data['driver_profile'] = driverProfile!.toJson();
    // }
    // if (restaurantProfile != null) {
    //   data['restaurant_profile'] = restaurantProfile!.toJson();
    // }
    return data;
  }
}

// Corresponds to UserRequest and PatchedUserRequest in OpenAPI spec
class UserUpdateRequestDto {
  final String? email;
  final String? phone;
  final String? fullName;
  final String? role; // e.g., "CUSTOMER"
  final CustomerProfileRequestDto? customerProfile;
  // final DriverProfileRequestDto? driverProfile;
  // final RestaurantProfileRequestDto? restaurantProfile;

  UserUpdateRequestDto({
    this.email,
    this.phone,
    this.fullName,
    this.role,
    this.customerProfile,
    // this.driverProfile,
    // this.restaurantProfile,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (email != null) {
      data['email'] = email;
    }
    if (phone != null) {
      data['phone'] = phone;
    }
    if (fullName != null) {
      data['full_name'] = fullName;
    }
    if (role != null) {
      data['role'] = role;
    }
    if (customerProfile != null) {
      data['customer_profile'] = customerProfile!.toJson();
    }
    // if (driverProfile != null) {
    //   data['driver_profile'] = driverProfile!.toJson();
    // }
    // if (restaurantProfile != null) {
    //   data['restaurant_profile'] = restaurantProfile!.toJson();
    // }
    return data;
  }
}
