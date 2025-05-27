import 'package:delivery_client/models/restaurant_model.dart';
import 'package:delivery_client/services/repositories/restaurant_repository.dart';

class GetRestaurantDetailsUseCase {
  final RestaurantRepository _restaurantRepository;

  GetRestaurantDetailsUseCase(this._restaurantRepository);

  Future<Restaurant> execute(String restaurantId) async {
    if (restaurantId.isEmpty) {
      throw Exception("Restaurant ID cannot be empty.");
    }
    return await _restaurantRepository.getRestaurantDetails(restaurantId);
  }
}
