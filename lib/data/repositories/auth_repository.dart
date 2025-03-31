import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:social_network/data/models/auth_models/signup_model.dart';
import 'package:social_network/domain/repositories/auth_repository.dart';

class AuthRepository implements AuthRepositoryy {
  final baseUrl = 'http://10.0.2.2:5151/api/Auth';

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
        return {"error": jsonDecode(response.body)["message"] ?? "Something went wrong"};
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      return {"error": "$e"};
    }
  }
}
