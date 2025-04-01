class LoginModelRequest {
  final String email;
  final String password;

  LoginModelRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

class LoginModelResponse {
  final String accessToken;
  final String refreshToken;

  LoginModelResponse({required this.accessToken, required this.refreshToken});

  factory LoginModelResponse.fromJson(Map<String, dynamic> json) {
    return LoginModelResponse(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }
}
