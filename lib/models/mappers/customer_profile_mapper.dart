import 'package:delivery_client/models/customer_profile_model.dart';
import 'package:delivery_client/models/dtos/customer_profile_dto.dart';
import 'package:delivery_client/models/address_model.dart'; // Assuming we might parse string address to Address object

class CustomerProfileMapper {
  static CustomerProfile fromDto(CustomerProfileDto dto) {
    // Basic conversion. If defaultAddressString needs to be parsed into an Address object,
    // that logic would go here or be handled by a dedicated AddressMapper.
    // For now, we'll keep it simple.
    Address? defaultAddrObj;
    if (dto.defaultAddress != null && dto.defaultLocationLat != null && dto.defaultLocationLng != null) {
      // This is a simplified assumption. Real parsing would be more complex.
      // You might need to split the dto.defaultAddress string or have more structured data.
      // For now, let's assume the string itself is just one part of the address.
      try {
        defaultAddrObj = Address(
          street: dto.defaultAddress!, // This is an oversimplification
          city: "Unknown", // Placeholder
          state: "Unknown", // Placeholder
          zipCode: "00000", // Placeholder
          latitude: double.tryParse(dto.defaultLocationLat!),
          longitude: double.tryParse(dto.defaultLocationLng!),
        );
      } catch (e) {
        print("Error parsing default address from DTO: $e");
      }
    }

    return CustomerProfile(
      defaultAddressString: dto.defaultAddress,
      defaultLocationLat: double.tryParse(dto.defaultLocationLat ?? ''),
      defaultLocationLng: double.tryParse(dto.defaultLocationLng ?? ''),
      defaultAddressObject: defaultAddrObj, // Or more complex parsing
    );
  }

  static CustomerProfileRequestDto toRequestDto(CustomerProfile model) {
    // If the model's defaultAddressObject is the source of truth, convert it back.
    // Otherwise, use the direct string and lat/lng if available.
    return CustomerProfileRequestDto(
      defaultAddress: model.defaultAddressObject?.street ?? model.defaultAddressString, // Example
      defaultLocationLat: model.defaultAddressObject?.latitude?.toString() ?? model.defaultLocationLat?.toString(),
      defaultLocationLng: model.defaultAddressObject?.longitude?.toString() ?? model.defaultLocationLng?.toString(),
    );
  }
}
