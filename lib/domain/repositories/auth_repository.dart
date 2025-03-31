import 'package:social_network/data/models/auth_models/signup_model.dart';

abstract class AuthRepositoryy {
  Future<Map<String,dynamic>> signup(SignupModel signupModel);
}
