import 'package:flutter/foundation.dart';

@immutable
class Address {
  final String? id; // Optional, if addresses are stored and have IDs
  final String street;
  final String? apartmentSuite;
  final String city;
  final String state; // Or province
  final String zipCode;
  final String? country; // Assuming country is part of it
  final double? latitude;
  final double? longitude;
  final String? label; // e.g., "Home", "Work"
  final String? deliveryInstructions;

  const Address({
    this.id,
    required this.street,
    this.apartmentSuite,
    required this.city,
    required this.state,
    required this.zipCode,
    this.country = 'US', // Default or from picker
    this.latitude,
    this.longitude,
    this.label,
    this.deliveryInstructions,
  });

  // For immutability and easy updates
  Address copyWith({
    String? id,
    String? street,
    String? apartmentSuite,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    double? latitude,
    double? longitude,
    String? label,
    String? deliveryInstructions,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      apartmentSuite: apartmentSuite ?? this.apartmentSuite,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      label: label ?? this.label,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
    );
  }

  // For easier debugging and logging
  @override
  String toString() {
    return 'Address(id: $id, street: $street, apartmentSuite: $apartmentSuite, city: $city, state: $state, zipCode: $zipCode, country: $country, latitude: $latitude, longitude: $longitude, label: $label, deliveryInstructions: $deliveryInstructions)';
  }

  // For equality comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.id == id &&
        other.street == street &&
        other.apartmentSuite == apartmentSuite &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.country == country &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.label == label &&
        other.deliveryInstructions == deliveryInstructions;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        street.hashCode ^
        apartmentSuite.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        country.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        label.hashCode ^
        deliveryInstructions.hashCode;
  }
}
