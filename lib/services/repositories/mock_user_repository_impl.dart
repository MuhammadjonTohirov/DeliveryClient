import 'package:delivery_client/models/user_model.dart';
import 'package:delivery_client/models/dtos/auth_tokens_dto.dart';
import 'package:delivery_client/models/customer_profile_model.dart';
import 'package:delivery_client/services/repositories/user_repository.dart';
import 'package:uuid/uuid.dart'; // For generating mock IDs

class MockUserRepositoryImpl implements UserRepository {
  User? _currentUser;
  AuthTokensDto? _currentTokens;
  final _uuid = const Uuid();

  @override
  Future<User> register(User user, String password, String passwordConfirm) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Basic validation (in a real scenario, server does this)
    if (password != passwordConfirm) {
      throw Exception("Passwords do not match");
    }
    if (user.email.isEmpty || user.fullName.isEmpty) {
      throw Exception("Email and Full Name are required");
    }

    // Simulate successful registration
    final newUserId = _uuid.v4();
    _currentUser = user.copyWith(
      id: newUserId,
      isActive: true,
      dateJoined: DateTime.now(),
      // Assuming customer profile is part of the initial user object for simplicity
      customerProfile: user.customerProfile ?? const CustomerProfile(),
    );

    // Simulate token generation upon registration
    _currentTokens = AuthTokensDto(
      access: 'mock_access_token_for_${_currentUser!.id}',
      refresh: 'mock_refresh_token_for_${_currentUser!.id}',
    );
    print("MockUserRepository: User registered: ${_currentUser!.email}, ID: ${_currentUser!.id}");
    return _currentUser!;
  }

  @override
  Future<AuthTokensDto> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Simulate login check (very basic)
    // In a real app, you'd compare against stored users or make an API call
    if ((_currentUser != null && _currentUser!.email == email) || email == "test@example.com") {
      // If no current user from registration, create a mock one for login
      if (_currentUser == null || _currentUser!.email != email) {
        final mockUserId = _uuid.v4();
        _currentUser = User(
          id: mockUserId,
          email: email,
          fullName: "Test User",
          role: UserRole.customer,
          isActive: true,
          dateJoined: DateTime.now().subtract(const Duration(days: 5)),
          customerProfile: const CustomerProfile(
            defaultAddressString: "123 Mock St",
            defaultLocationLat: 34.0522,
            defaultLocationLng: -118.2437,
          ),
        );
      }
      _currentTokens = AuthTokensDto(
        access: 'mock_access_token_for_${_currentUser!.id}',
        refresh: 'mock_refresh_token_for_${_currentUser!.id}',
      );
      print("MockUserRepository: User logged in: $email");
      return _currentTokens!;
    } else {
      throw Exception("Invalid credentials");
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("MockUserRepository: User logged out: ${_currentUser?.email}");
    _currentUser = null;
    _currentTokens = null;
    // In a real app, invalidate tokens on server / clear secure storage
  }

  @override
  Future<User> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser != null && _currentTokens != null) {
      print("MockUserRepository: Fetched profile for: ${_currentUser!.email}");
      return _currentUser!;
    } else {
      throw Exception("Not authenticated or user profile not found");
    }
  }

  @override
  Future<User> updateProfile(User user) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser != null && _currentTokens != null && _currentUser!.id == user.id) {
      _currentUser = user;
      print("MockUserRepository: Updated profile for: ${_currentUser!.email}");
      return _currentUser!;
    } else {
      throw Exception("Not authenticated or user mismatch");
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser == null || _currentTokens == null) {
      throw Exception("Not authenticated");
    }
    // Simulate password change
    print("MockUserRepository: Password changed for ${_currentUser!.email}. Old: $oldPassword, New: $newPassword");
    // In a real app, you'd validate oldPassword and update it.
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate sending password reset link
    print("MockUserRepository: Password reset link requested for $email");
    // In a real app, an email would be sent.
  }

  // Mock implementation for token refresh if needed
  // @override
  // Future<AuthTokensDto> refreshToken(String refreshToken) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   if (_currentTokens != null && _currentTokens!.refresh == refreshToken) {
  //     _currentTokens = AuthTokensDto(access: 'new_mock_access_token', refresh: 'new_mock_refresh_token');
  //     print("MockUserRepository: Tokens refreshed");
  //     return _currentTokens!;
  //   } else {
  //     throw Exception("Invalid refresh token");
  //   }
  // }
}
