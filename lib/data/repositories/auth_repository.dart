import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_network/data/models/auth_model/login_model.dart';
import 'package:social_network/data/models/auth_model/signup_model.dart';
import 'package:social_network/domain/repositories/auth_repository.dart';

class AuthRepository implements AuthRepositoryy {
  final baseUrl = 'http://10.0.2.2:5151/api/Auth';
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String accessTokenKey = "access_token";
  final String refreshTokenKey = "refresh_token";

  @override
  Future<Map<String, dynamic>> signup(SignupModel signup) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(signup.toJson()),
    );

    try {
      if (response.statusCode == 201) {
        return {"success": jsonDecode(response.body)["message"] ?? "success"};
      } else if (response.statusCode == 400) {
        return {
          "error":
              jsonDecode(response.body)["message"] ?? "Something went wrong",
        };
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return {"error": "$e"};
    }
  }

  @override
  Future<Map<String, dynamic>> login(LoginModelRequest loginRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"accept": "*/*", "Content-Type": "application/json"},
      body: jsonEncode(loginRequest.toJson()),
    );

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await secureStorage.write(
          key: accessTokenKey,
          value: data['accessToken'],
        );
        await secureStorage.write(
          key: refreshTokenKey,
          value: data['refreshToken'],
        );

        return {"success": "Login success"};
      } else {
        return {"error": jsonDecode(response.body)["message"]};
      }
    } catch (e) {
      return {"error": "$e"};
    }
  }

  @override
  Future<bool> logout() async {
    final refreshToken = await secureStorage.read(key: refreshTokenKey);

    if (refreshToken == null || refreshToken.isEmpty) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {"accept": "*/*", "Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> refreshToken() async {
    final refreshToken = await secureStorage.read(key: refreshTokenKey);
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/refresh-token'),
      headers: {"accept": "*/*", "Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await secureStorage.write(
        key: accessTokenKey,
        value: data['accessToken'],
      );
      return true;
    } else {
      logout();
      return false;
    }
  }
}
