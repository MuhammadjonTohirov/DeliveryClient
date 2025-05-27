import 'package:flutter/foundation.dart';
import 'package:delivery_client/models/customer_profile_model.dart';
// import 'package:delivery_client/models/driver_profile_model.dart'; // To be created
// import 'package:delivery_client/models/restaurant_profile_model.dart'; // To be created

enum UserRole { customer, driver, restaurant, admin, unknown }

UserRole roleFromString(String? roleString) {
  switch (roleString?.toUpperCase()) {
    case 'CUSTOMER':
      return UserRole.customer;
    case 'DRIVER':
      return UserRole.driver;
    case 'RESTAURANT':
      return UserRole.restaurant;
    case 'ADMIN':
      return UserRole.admin;
    default:
      return UserRole.unknown;
  }
}

String roleToString(UserRole role) {
  switch (role) {
    case UserRole.customer:
      return 'CUSTOMER';
    case UserRole.driver:
      return 'DRIVER';
    case UserRole.restaurant:
      return 'RESTAURANT';
    case UserRole.admin:
      return 'ADMIN';
    default:
      return 'UNKNOWN';
  }
}

@immutable
class User {
  final String id;
  final String email;
  final String? phone;
  final String fullName;
  final UserRole role;
  final bool isActive;
  final DateTime dateJoined;
  final CustomerProfile? customerProfile;
  // final DriverProfile? driverProfile; // To be added
  // final RestaurantProfile? restaurantProfile; // To be added

  const User({
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

  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    UserRole? role,
    bool? isActive,
    DateTime? dateJoined,
    CustomerProfile? customerProfile,
    // DriverProfile? driverProfile,
    // RestaurantProfile? restaurantProfile,
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
      // driverProfile: driverProfile ?? this.driverProfile,
      // restaurantProfile: restaurantProfile ?? this.restaurantProfile,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, phone: $phone, fullName: $fullName, role: $role, isActive: $isActive, dateJoined: $dateJoined, customerProfile: $customerProfile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.phone == phone &&
        other.fullName == fullName &&
        other.role == role &&
        other.isActive == isActive &&
        other.dateJoined == dateJoined &&
        other.customerProfile == customerProfile;
    // other.driverProfile == driverProfile && // To be added
    // other.restaurantProfile == restaurantProfile; // To be added
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        fullName.hashCode ^
        role.hashCode ^
        isActive.hashCode ^
        dateJoined.hashCode ^
        customerProfile.hashCode;
    // driverProfile.hashCode ^ // To be added
    // restaurantProfile.hashCode; // To be added
  }
}
