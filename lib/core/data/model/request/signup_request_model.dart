import 'package:golf_app/core/domain/entity/request/signup_request_entity.dart';

class SignupRequestModel extends SignupRequestEntity {
  SignupRequestModel({
    required super.fullName,
    required super.phone,
    required super.email,
    required super.password,
  });

  factory SignupRequestModel.fromEntity(SignupRequestEntity request) {
    return SignupRequestModel(
      fullName: request.fullName,
      phone: request.phone,
      email: request.email,
      password: request.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}
