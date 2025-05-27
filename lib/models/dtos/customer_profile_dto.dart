// Corresponds to CustomerProfileRequest and CustomerProfile in OpenAPI spec

class CustomerProfileRequestDto {
  final String? defaultAddress;
  final String? defaultLocationLat;
  final String? defaultLocationLng;

  CustomerProfileRequestDto({this.defaultAddress, this.defaultLocationLat, this.defaultLocationLng});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (defaultAddress != null) {
      data['default_address'] = defaultAddress;
    }
    if (defaultLocationLat != null) {
      data['default_location_lat'] = defaultLocationLat;
    }
    if (defaultLocationLng != null) {
      data['default_location_lng'] = defaultLocationLng;
    }
    return data;
  }
}

class CustomerProfileDto {
  final String? defaultAddress;
  final String? defaultLocationLat; // API returns as string
  final String? defaultLocationLng; // API returns as string

  CustomerProfileDto({this.defaultAddress, this.defaultLocationLat, this.defaultLocationLng});

  factory CustomerProfileDto.fromJson(Map<String, dynamic> json) {
    return CustomerProfileDto(
      defaultAddress: json['default_address'],
      defaultLocationLat: json['default_location_lat']?.toString(),
      defaultLocationLng: json['default_location_lng']?.toString(),
    );
  }
}
