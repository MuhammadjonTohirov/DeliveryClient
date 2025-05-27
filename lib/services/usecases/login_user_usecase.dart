import 'package:delivery_client/services/repositories/user_repository.dart';
import 'package:delivery_client/models/dtos/auth_tokens_dto.dart';

class LoginUserUseCase {
  final UserRepository _userRepository;

  LoginUserUseCase(this._userRepository);

  Future<AuthTokensDto> execute(String email, String password) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception("Invalid email format.");
    }
    if (password.isEmpty) {
      throw Exception("Password cannot be empty.");
    }
    return await _userRepository.login(email, password);
  }
}
