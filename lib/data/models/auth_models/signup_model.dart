class SignupModel {
  final String username;
  final String email;
  final String password;
  final DateTime dateOfBirth;
  final String fullName;
  final int gender;

  SignupModel({
    required this.username,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.fullName,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "dateOfBirth": dateOfBirth.toUtc().toIso8601String(),
      "fullName": fullName,
      "gender": gender,
    };
  }
}
