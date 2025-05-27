import 'package:delivery_client/services/repositories/user_repository.dart';

class LogoutUserUseCase {
  final UserRepository _userRepository;

  LogoutUserUseCase(this._userRepository);

  Future<void> execute() async {
    return await _userRepository.logout();
  }
}
