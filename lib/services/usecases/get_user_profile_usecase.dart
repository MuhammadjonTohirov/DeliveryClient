import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/services/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository _userRepository;

  GetUserProfileUseCase(this._userRepository);

  Future<User> execute() async {
    return await _userRepository.getProfile();
  }
}
