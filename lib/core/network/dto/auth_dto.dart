import 'base_dto.dart';

class CustomerProfileDto {
  final String? defaultAddress;
  final String? defaultLocationLat;
  final String? defaultLocationLng;

  const CustomerProfileDto({
    this.defaultAddress,
    this.defaultLocationLat,
    this.defaultLocationLng,
  });

  factory CustomerProfileDto.fromJson(Map<String, dynamic> json) {
    return CustomerProfileDto(
      defaultAddress: json['default_address'] as String?,
      defaultLocationLat: json['default_location_lat'] as String?,
      defaultLocationLng: json['default_location_lng'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_address': defaultAddress,
      'default_location_lat': defaultLocationLat,
      'default_location_lng': defaultLocationLng,
    };
  }
}

class DriverProfileDto {
  final String? vehicleType;
  final String? licenseNumber;

  const DriverProfileDto({
    this.vehicleType,
    this.licenseNumber,
  });

  factory DriverProfileDto.fromJson(Map<String, dynamic> json) {
    return DriverProfileDto(
      vehicleType: json['vehicle_type'] as String?,
      licenseNumber: json['license_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_type': vehicleType,
      'license_number': licenseNumber,
    };
  }
}

class RestaurantProfileDto {
  final String businessName;
  final String businessAddress;
  final String? businessRegistrationNumber;

  const RestaurantProfileDto({
    required this.businessName,
    required this.businessAddress,
    this.businessRegistrationNumber,
  });

  factory RestaurantProfileDto.fromJson(Map<String, dynamic> json) {
    return RestaurantProfileDto(
      businessName: json['business_name'] as String,
      businessAddress: json['business_address'] as String,
      businessRegistrationNumber:
          json['business_registration_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business_name': businessName,
      'business_address': businessAddress,
      'business_registration_number': businessRegistrationNumber,
    };
  }
}

class UserDto {
  final String id;
  final String email;
  final String? phone;
  final String fullName;
  final UserRole role;
  final bool isActive;
  final DateTime dateJoined;
  final CustomerProfileDto? customerProfile;
  final DriverProfileDto? driverProfile;
  final RestaurantProfileDto? restaurantProfile;

  const UserDto({
    required this.id,
    required this.email,
    this.phone,
    required this.fullName,
    required this.role,
    required this.isActive,
    required this.dateJoined,
    this.customerProfile,
    this.driverProfile,
    this.restaurantProfile,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      fullName: json['full_name'] as String,
      role: UserRole.fromString(json['role'] as String),
      isActive: json['is_active'] as bool,
      dateJoined: DateTime.parse(json['date_joined'] as String),
      customerProfile: json['customer_profile'] != null
          ? CustomerProfileDto.fromJson(
              json['customer_profile'] as Map<String, dynamic>)
          : null,
      driverProfile: json['driver_profile'] != null
          ? DriverProfileDto.fromJson(
              json['driver_profile'] as Map<String, dynamic>)
          : null,
      restaurantProfile: json['restaurant_profile'] != null
          ? RestaurantProfileDto.fromJson(
              json['restaurant_profile'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'full_name': fullName,
      'role': role.value,
      'is_active': isActive,
      'date_joined': dateJoined.toIso8601String(),
      'customer_profile': customerProfile?.toJson(),
      'driver_profile': driverProfile?.toJson(),
      'restaurant_profile': restaurantProfile?.toJson(),
    };
  }
}

class UserRegistrationRequestDto {
  final String email;
  final String? phone;
  final String fullName;
  final String password;
  final String passwordConfirm;
  final UserRole role;
  final CustomerProfileDto? customerProfile;
  final DriverProfileDto? driverProfile;
  final RestaurantProfileDto? restaurantProfile;

  const UserRegistrationRequestDto({
    required this.email,
    this.phone,
    required this.fullName,
    required this.password,
    required this.passwordConfirm,
    required this.role,
    this.customerProfile,
    this.driverProfile,
    this.restaurantProfile,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'full_name': fullName,
      'password': password,
      'password_confirm': passwordConfirm,
      'role': role.value,
      'customer_profile': customerProfile?.toJson(),
      'driver_profile': driverProfile?.toJson(),
      'restaurant_profile': restaurantProfile?.toJson(),
    };
  }
}

class UserUpdateRequestDto {
  final String? email;
  final String? phone;
  final String? fullName;
  final UserRole? role;
  final CustomerProfileDto? customerProfile;
  final DriverProfileDto? driverProfile;
  final RestaurantProfileDto? restaurantProfile;

  const UserUpdateRequestDto({
    this.email,
    this.phone,
    this.fullName,
    this.role,
    this.customerProfile,
    this.driverProfile,
    this.restaurantProfile,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (email != null) json['email'] = email;
    if (phone != null) json['phone'] = phone;
    if (fullName != null) json['full_name'] = fullName;
    if (role != null) json['role'] = role!.value;
    if (customerProfile != null) {
      json['customer_profile'] = customerProfile!.toJson();
    }
    if (driverProfile != null) {
      json['driver_profile'] = driverProfile!.toJson();
    }
    if (restaurantProfile != null) {
      json['restaurant_profile'] = restaurantProfile!.toJson();
    }
    return json;
  }
}

class LoginRequestDto {
  final String email;
  final String password;

  const LoginRequestDto({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class TokenResponseDto {
  final String access;
  final String refresh;

  const TokenResponseDto({
    required this.access,
    required this.refresh,
  });

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) {
    return TokenResponseDto(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );
  }
}

class TokenRefreshRequestDto {
  final String refresh;

  const TokenRefreshRequestDto({required this.refresh});

  Map<String, dynamic> toJson() {
    return {'refresh': refresh};
  }
}

class TokenRefreshResponseDto {
  final String access;

  const TokenRefreshResponseDto({required this.access});

  factory TokenRefreshResponseDto.fromJson(Map<String, dynamic> json) {
    return TokenRefreshResponseDto(
      access: json['access'] as String,
    );
  }
}

class ChangePasswordRequestDto {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequestDto({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }
}
