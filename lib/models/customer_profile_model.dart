import 'package:flutter/foundation.dart';
import 'package:delivery_client/models/address_model.dart';

@immutable
class CustomerProfile {
  final String? defaultAddressString; // From API: default_address (string, nullable)
  final double? defaultLocationLat;
  final double? defaultLocationLng;
  final Address? defaultAddressObject; // Parsed or constructed Address object

  const CustomerProfile({
    this.defaultAddressString,
    this.defaultLocationLat,
    this.defaultLocationLng,
    this.defaultAddressObject,
  });

  CustomerProfile copyWith({
    String? defaultAddressString,
    double? defaultLocationLat,
    double? defaultLocationLng,
    Address? defaultAddressObject,
  }) {
    return CustomerProfile(
      defaultAddressString: defaultAddressString ?? this.defaultAddressString,
      defaultLocationLat: defaultLocationLat ?? this.defaultLocationLat,
      defaultLocationLng: defaultLocationLng ?? this.defaultLocationLng,
      defaultAddressObject: defaultAddressObject ?? this.defaultAddressObject,
    );
  }

  @override
  String toString() {
    return 'CustomerProfile(defaultAddressString: $defaultAddressString, defaultLocationLat: $defaultLocationLat, defaultLocationLng: $defaultLocationLng, defaultAddressObject: $defaultAddressObject)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerProfile &&
        other.defaultAddressString == defaultAddressString &&
        other.defaultLocationLat == defaultLocationLat &&
        other.defaultLocationLng == defaultLocationLng &&
        other.defaultAddressObject == defaultAddressObject;
  }

  @override
  int get hashCode {
    return defaultAddressString.hashCode ^
        defaultLocationLat.hashCode ^
        defaultLocationLng.hashCode ^
        defaultAddressObject.hashCode;
  }
}
