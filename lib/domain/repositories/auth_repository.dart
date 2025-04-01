import 'package:social_network/data/models/auth_models/login_model.dart';
import 'package:social_network/data/models/auth_models/signup_model.dart';

abstract class AuthRepositoryy {
  Future<Map<String, dynamic>> signup(SignupModel signupModel);
  Future<Map<String, dynamic>> login(LoginModelRequest request);
  Future<bool> logout();
  Future<bool> refreshToken();
}
