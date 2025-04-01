import 'package:flutter/material.dart';
import 'package:social_network/data/models/auth_models/login_model.dart';
import 'package:social_network/data/repositories/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String? passwordError, emailError;
  Future<void> login({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    emailError = email.trim().isEmpty ? "Please enter email" : null;
    passwordError = password.isEmpty ? "Please enter password" : null;

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      final loginRequest = LoginModelRequest(
        email: email.trim(),
        password: password,
      );

      final loginResponse = await _authRepository.login(loginRequest);

      _setLoading(false);

      if (loginResponse.containsKey("success")) {
        onSuccess();
      } else {
        onError(loginResponse["error"]);
      }
    } finally {
      _setLoading(false);
    }
  }
}
