import 'package:dio/dio.dart';
import 'package:golf_app/core/data/model/request/signup_request_model.dart';

import '../../constants/endpoints.dart';
import '../model/request/login_request_model.dart';

abstract class AuthDataSource {
  Future<Map<String, dynamic>> signup(SignupRequestModel requestModel);
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel);
  Future<Map<String, dynamic>> refreshToken(String refreshToken);
}

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> signup(SignupRequestModel requestModel) async {
    final response = await dio.post(
      EndPoints.signup,
      data: requestModel.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> login(LoginRequestModel requestModel) async {
    final response = await dio.post(
      EndPoints.login,
      data: requestModel.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await dio.get(
      EndPoints.refresh_token,
      options: Options(
        headers: {'Authorization': 'Bearer $refreshToken'},
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
