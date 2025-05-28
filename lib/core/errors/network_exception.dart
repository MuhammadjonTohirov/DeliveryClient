import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? details;

  const NetworkException({
    required this.message,
    required this.statusCode,
    this.details,
  });

  factory NetworkException.fromResponse(http.Response response) {
    String message = 'Unknown error occurred';
    Map<String, dynamic>? details;

    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        details = body;
        
        // Try to extract error message from common API error formats
        if (body.containsKey('message')) {
          message = body['message'].toString();
        } else if (body.containsKey('error')) {
          message = body['error'].toString();
        } else if (body.containsKey('detail')) {
          message = body['detail'].toString();
        } else if (body.containsKey('non_field_errors')) {
          final errors = body['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            message = errors.first.toString();
          }
        } else {
          message = 'HTTP ${response.statusCode}';
        }
      }
    } catch (e) {
      message = 'HTTP ${response.statusCode}';
    }

    return NetworkException(
      message: message,
      statusCode: response.statusCode,
      details: details,
    );
  }

  @override
  String toString() {
    return 'NetworkException: $message (Status: $statusCode)';
  }
}

class ValidationException extends NetworkException {
  final Map<String, List<String>> fieldErrors;

  const ValidationException({
    required super.message,
    required super.statusCode,
    required this.fieldErrors,
    super.details,
  });

  factory ValidationException.fromResponse(http.Response response) {
    final networkException = NetworkException.fromResponse(response);
    final fieldErrors = <String, List<String>>{};

    if (networkException.details != null) {
      for (final entry in networkException.details!.entries) {
        if (entry.value is List) {
          fieldErrors[entry.key] = List<String>.from(
            (entry.value as List).map((e) => e.toString()),
          );
        } else if (entry.value is String) {
          fieldErrors[entry.key] = [entry.value as String];
        }
      }
    }

    return ValidationException(
      message: networkException.message,
      statusCode: networkException.statusCode,
      fieldErrors: fieldErrors,
      details: networkException.details,
    );
  }

  String? getFieldError(String fieldName) {
    final errors = fieldErrors[fieldName];
    return errors?.isNotEmpty == true ? errors!.first : null;
  }
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.statusCode = 401,
    super.details,
  });
}

class ForbiddenException extends NetworkException {
  const ForbiddenException({
    super.message = 'Access forbidden',
    super.statusCode = 403,
    super.details,
  });
}

class NotFoundException extends NetworkException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
    super.details,
  });
}

class ServerException extends NetworkException {
  const ServerException({
    super.message = 'Internal server error',
    super.statusCode = 500,
    super.details,
  });
}
