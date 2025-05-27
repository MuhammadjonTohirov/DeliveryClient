import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/services/repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final UserRepository _userRepository;

  UpdateUserProfileUseCase(this._userRepository);

  Future<User> execute(User user) async {
    // Add any specific validation for user profile update here
    if (user.fullName.isEmpty) {
      throw Exception("Full name cannot be empty.");
    }
    return await _userRepository.updateProfile(user);
  }
}
