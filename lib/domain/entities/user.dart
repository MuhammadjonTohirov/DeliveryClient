import 'enums.dart';

class CustomerProfile {
  final String? defaultAddress;
  final double? defaultLocationLat;
  final double? defaultLocationLng;

  const CustomerProfile({
    this.defaultAddress,
    this.defaultLocationLat,
    this.defaultLocationLng,
  });

  CustomerProfile copyWith({
    String? defaultAddress,
    double? defaultLocationLat,
    double? defaultLocationLng,
  }) {
    return CustomerProfile(
      defaultAddress: defaultAddress ?? this.defaultAddress,
      defaultLocationLat: defaultLocationLat ?? this.defaultLocationLat,
      defaultLocationLng: defaultLocationLng ?? this.defaultLocationLng,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerProfile &&
          runtimeType == other.runtimeType &&
          defaultAddress == other.defaultAddress &&
          defaultLocationLat == other.defaultLocationLat &&
          defaultLocationLng == other.defaultLocationLng;

  @override
  int get hashCode =>
      defaultAddress.hashCode ^
      defaultLocationLat.hashCode ^
      defaultLocationLng.hashCode;
}

class DriverProfile {
  final String? vehicleType;
  final String? licenseNumber;

  const DriverProfile({
    this.vehicleType,
    this.licenseNumber,
  });

  DriverProfile copyWith({
    String? vehicleType,
    String? licenseNumber,
  }) {
    return DriverProfile(
      vehicleType: vehicleType ?? this.vehicleType,
      licenseNumber: licenseNumber ?? this.licenseNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverProfile &&
          runtimeType == other.runtimeType &&
          vehicleType == other.vehicleType &&
          licenseNumber == other.licenseNumber;

  @override
  int get hashCode => vehicleType.hashCode ^ licenseNumber.hashCode;
}

class RestaurantProfile {
  final String businessName;
  final String businessAddress;
  final String? businessRegistrationNumber;

  const RestaurantProfile({
    required this.businessName,
    required this.businessAddress,
    this.businessRegistrationNumber,
  });

  RestaurantProfile copyWith({
    String? businessName,
    String? businessAddress,
    String? businessRegistrationNumber,
  }) {
    return RestaurantProfile(
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessRegistrationNumber:
          businessRegistrationNumber ?? this.businessRegistrationNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantProfile &&
          runtimeType == other.runtimeType &&
          businessName == other.businessName &&
          businessAddress == other.businessAddress &&
          businessRegistrationNumber == other.businessRegistrationNumber;

  @override
  int get hashCode =>
      businessName.hashCode ^
      businessAddress.hashCode ^
      businessRegistrationNumber.hashCode;
}

class User {
  final String id;
  final String email;
  final String? phone;
  final String fullName;
  final UserRole role;
  final bool isActive;
  final DateTime dateJoined;
  final CustomerProfile? customerProfile;
  final DriverProfile? driverProfile;
  final RestaurantProfile? restaurantProfile;

  const User({
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

  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    UserRole? role,
    bool? isActive,
    DateTime? dateJoined,
    CustomerProfile? customerProfile,
    DriverProfile? driverProfile,
    RestaurantProfile? restaurantProfile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      dateJoined: dateJoined ?? this.dateJoined,
      customerProfile: customerProfile ?? this.customerProfile,
      driverProfile: driverProfile ?? this.driverProfile,
      restaurantProfile: restaurantProfile ?? this.restaurantProfile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          phone == other.phone &&
          fullName == other.fullName &&
          role == other.role &&
          isActive == other.isActive &&
          dateJoined == other.dateJoined &&
          customerProfile == other.customerProfile &&
          driverProfile == other.driverProfile &&
          restaurantProfile == other.restaurantProfile;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      fullName.hashCode ^
      role.hashCode ^
      isActive.hashCode ^
      dateJoined.hashCode ^
      customerProfile.hashCode ^
      driverProfile.hashCode ^
      restaurantProfile.hashCode;
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  AuthTokens copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthTokens(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTokens &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken;

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
