import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/services/repositories/restaurant_repository.dart';

class GetRestaurantsUseCase {
  final RestaurantRepository _restaurantRepository;

  GetRestaurantsUseCase(this._restaurantRepository);

  Future<List<Restaurant>> execute({
    bool? isOpen,
    String? searchTerm,
    // Add other filter parameters as needed
  }) async {
    // Add any business logic/validation before calling repository
    return await _restaurantRepository.getRestaurants(
      isOpen: isOpen,
      searchTerm: searchTerm,
      // Pass other filters
    );
  }
}
