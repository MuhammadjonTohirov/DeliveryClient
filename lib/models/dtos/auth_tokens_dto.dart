// Corresponds to the token response from /api/users/token/ and /api/users/token/refresh/
class AuthTokensDto {
  final String access;
  final String? refresh; // Refresh token might not always be present (e.g. after refresh itself)

  AuthTokensDto({required this.access, this.refresh});

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) {
    return AuthTokensDto(access: json['access'], refresh: json['refresh']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'access': access};
    if (refresh != null) {
      data['refresh'] = refresh;
    }
    return data;
  }
}

// Corresponds to CustomTokenObtainPairRequest
class LoginRequestDto {
  final String email;
  final String password;

  LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

// Corresponds to TokenRefreshRequest
class TokenRefreshRequestDto {
  final String refresh;

  TokenRefreshRequestDto({required this.refresh});

  Map<String, dynamic> toJson() {
    return {'refresh': refresh};
  }
}
