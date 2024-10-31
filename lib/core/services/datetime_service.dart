import 'package:dio/dio.dart';

import '../constants/endpoints.dart';

class DateTimeService {
  final Dio dio;

  DateTimeService({required this.dio});

  Future<DateTime> getDateTime() async {
    final response = await dio.get(EndPoints.datetime);
    return DateTime.parse(response.data);
  }
}
