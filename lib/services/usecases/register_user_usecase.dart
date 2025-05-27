import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/services/repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository _userRepository;

  RegisterUserUseCase(this._userRepository);

  Future<User> execute(User user, String password, String passwordConfirm) async {
    // You can add more business logic here if needed, e.g., complex validation
    if (password.length < 6) {
      throw Exception("Password must be at least 6 characters long.");
    }
    return await _userRepository.register(user, password, passwordConfirm);
  }
}
