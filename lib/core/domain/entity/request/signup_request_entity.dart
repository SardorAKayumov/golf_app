class SignupRequestEntity {
  final String fullName;
  final String phone;
  final String email;
  final String password;

  SignupRequestEntity({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
  });
}
