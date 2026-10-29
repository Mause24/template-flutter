import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter/globals/providers/env_reader.dart';
import 'package:template_flutter/stores/auth_store.dart';

/// Provider for a configured [Dio] client.
///
/// The client uses the [BASE_URL] from the `.env` file and automatically
/// attaches the authentication token (if present) to every request.
///
/// For Android emulators, `localhost` refers to the emulator itself, so we
/// replace it with `10.0.2.2` which maps to the host machine. We also switch to
/// `http` for local development because the default self‑signed certificate
/// will cause a connection error.
final dioProvider = Provider<Dio>((ref) {
  // Load base URL from environment variables.
  String baseUrl = ENV.baseUrl;

  // Adjust base URL for different platforms when running locally.
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      // Android emulator: use 10.0.2.2 and http.
      baseUrl = baseUrl.replaceAll(RegExp(r'^https?://'), 'http://');
      baseUrl = baseUrl.replaceFirst('localhost', '10.0.2.2');
    } else if (Platform.isIOS) {
      // iOS simulator can reach localhost directly.
      baseUrl = baseUrl.replaceAll(RegExp(r'^https?://'), 'http://');
    }
  }

  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  // Interceptor to add Authorization header when a token exists.
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = ref.read(authProvider).token;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
});
