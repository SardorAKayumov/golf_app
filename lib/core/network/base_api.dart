import 'package:dio/dio.dart';

import '../constants/endpoints.dart';

class BaseApi {
  final _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.base_url,
      validateStatus: (status) => true,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Dio get dio => _dio;
}
