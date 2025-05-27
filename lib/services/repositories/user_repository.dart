import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/models/dtos/auth_tokens_dto.dart'; // To be created

// Abstract class defining the contract for user-related data operations
abstract class UserRepository {
  Future<User> register(User user, String password, String passwordConfirm);
  Future<AuthTokensDto> login(String email, String password); // Returns tokens
  Future<void> logout(); // May involve token invalidation on server
  Future<User> getProfile();
  Future<User> updateProfile(User user);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> requestPasswordReset(String email);
  // Future<AuthTokensDto> refreshToken(String refreshToken); // If implementing token refresh
}
