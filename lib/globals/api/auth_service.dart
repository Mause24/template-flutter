import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/api/api_client.dart';
import 'package:template_flutter/globals/models/globals.dart';
import 'package:template_flutter/globals/models/modules/auth_models.dart';

/// Custom exceptions for authentication errors.
class EmailAlreadyExistsException implements Exception {
  final String message;
  EmailAlreadyExistsException([this.message = 'Email already exists']);
  @override
  String toString() => 'EmailAlreadyExistsException: $message';
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException([this.message = 'User not found']);
  @override
  String toString() => 'UserNotFoundException: $message';
}

class IncorrectPasswordException implements Exception {
  final String message;
  IncorrectPasswordException([this.message = 'Incorrect password']);
  @override
  String toString() => 'IncorrectPasswordException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
  @override
  String toString() => 'ServerException: $message';
}

class ConnectionException implements Exception {
  final String message;
  ConnectionException([this.message = 'Connection error']);
  @override
  String toString() => 'ConnectionException: $message';
}

/// Service responsible for authentication related API calls.
class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  /// Registers a new user.
  ///
  /// Sends a POST request to `/register` with the required fields.
  /// Throws custom exceptions based on the HTTP status code returned by the
  /// backend.
  Future<bool> register({
    required String name,
    required String lastname,
    required String email,
    required String password,
    required String phone,
    required String companyName,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'lastname': lastname,
          'email': email,
          'password': password,
          'phone': phone,
          'companyName': companyName,
        },
      );
      if (response.statusCode == 201 && response.data != null) {
        // 3. Mapeamos manualmente el JSON al modelo genérico de tu app
        final responseModel = ResponseModel<UserResponse>.fromJson(
          response.data,
          (json) {
            final jsonParsed = json as Map<String, dynamic>;
            return UserResponse.fromJson({
              "name": jsonParsed['name'].toString(),
              "lastname": jsonParsed['lastname'].toString(),
              "email": jsonParsed['email'].toString(),
              "phone": jsonParsed['phone'].toString(),
              "companyName": jsonParsed['companyName'],
              "avatarImage": jsonParsed['avatarImage'] as String?,
              "profile": jsonParsed['Profile'],
            });
          },
        );
        return responseModel.data.toJson().isNotEmpty;
      }
      return false;
    } on DioException catch (e) {
      // Map backend error codes to custom exceptions.
      switch (e.response?.statusCode) {
        case 409:
          throw EmailAlreadyExistsException();
        case 404:
          throw UserNotFoundException();
        case 500:
          throw ServerException();
        default:
          // Handle connection errors (e.g., refused, timeout).
          if (e.type == DioExceptionType.connectionError ||
              e.message?.contains('Connection refused') == true ||
              e.message?.contains('SocketException') == true) {
            throw ConnectionException(
              'Failed to connect to the server. Please check your network and server status.',
            );
          }
          rethrow;
      }
    }
  }

  /// Login a user.
  ///
  /// Sends a POST request to `/auth/login` with email and password.
  /// Returns a [LoginResponse] on success.
  /// Throws custom exceptions based on status codes.
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200 && response.data != null) {
        final responseModel = ResponseModel<LoginResponse>.fromJson(
          response.data as Map<String, dynamic>,
          (json) {
            final jsonParsed = json as Map<String, dynamic>;
            return LoginResponse.fromJson({
              "token": jsonParsed['token'],
              "user": {
                "name": jsonParsed['user']['name'].toString(),
                "lastname": jsonParsed['user']['lastname'].toString(),
                "email": jsonParsed['user']['email'].toString(),
                "phone": jsonParsed['user']['phone'].toString(),
                "companyName": jsonParsed['user']['companyName'],
                "avatarImage": jsonParsed['user']['avatarImage'] as String?,
                "profile": jsonParsed['user']['Profile'],
              },
            });
          },
        );
        return responseModel.data;
      }
      throw ServerException('Unexpected response from server');
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          throw IncorrectPasswordException();
        case 404:
          throw UserNotFoundException();
        case 500:
          throw ServerException();
        default:
          if (e.type == DioExceptionType.connectionError ||
              e.message?.contains('Connection refused') == true ||
              e.message?.contains('SocketException') == true) {
            throw ConnectionException(
              'Failed to connect to the server. Please check your network and server status.',
            );
          }
          rethrow;
      }
    }
  }
}

/// Riverpod provider for [AuthService].
final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.read(dioProvider);
  return AuthService(dio);
});
