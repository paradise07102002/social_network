import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_network/core/utils/validator.dart';
import 'package:social_network/data/models/auth_models/signup_model.dart';
import 'package:social_network/data/repositories/auth_repository.dart';

class SignupController extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //
  String? userNameError, emailError, passwordError, rePasswordError;

  Future<void> signup({
    required String userName,
    required String email,
    required String password,
    required String rePassword,
    required DateTime dateOfBirth,
    required String fullName,
    required int gender,
    required Function() onError,
    required Function() onSuccess,
  }) async {
    userNameError = userName.trim().isEmpty ? "Please enter username" : null;
    emailError = email.trim().isEmpty ? "Please enter email" : null;
    passwordError = password.isEmpty ? "Please enter password" : null;
    rePasswordError = rePassword.isEmpty ? "Please confirm password" : null;

    if (userNameError != null ||
        emailError != null ||
        passwordError != null ||
        rePasswordError != null) {
      notifyListeners();
      return;
    }

    if (!Validator.isValidEmail(email.trim())) {
      emailError = "Email is not in correct format";
      notifyListeners();
      return;
    }

    if (!Validator.isValidPassword(password)) {
      passwordError = "Mật khẩu yếu";
      notifyListeners();
      return;
    }

    if (password != rePassword) {
      rePasswordError = "Password do not match";
      notifyListeners();
      return;
    }

    try {
      setLoading(true);

      final signupModel = SignupModel(
        username: userName.trim(),
        email: email.trim(),
        password: password,
        dateOfBirth: dateOfBirth,
        fullName: fullName,
        gender: gender,
      );

      final response = await authRepository.signup(signupModel);

      setLoading(false);

      if (response.containsKey("error")) {
        emailError = response["error"];
        notifyListeners();
        return;
      } else {
        Fluttertoast.showToast(
          msg: response["success"],
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.green,
        );
        return;
      }
    } finally {
      setLoading(false);
    }
  }

  //
  String? errorMessage;

  bool validateField(String input, String errorMessage) {
    if (input.isEmpty) {
      this.errorMessage = errorMessage;
      notifyListeners();
      return false;
    }

    this.errorMessage = null;
    notifyListeners();
    return true;
  }
}
