// ignore_for_file: constant_identifier_names
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage;

  SecureStorage()
      : _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  static const ACCESS_TOKEN = "access_token";
  static const REFRESH_TOKEN = "refresh_token";
  static const STUDENT_ID = "student_id";
  static const STUDENT_EXTERNAL_ID = "student_external_id";
  static const BRANCH_ID = "branch_id";

  Future<void> setAccessToken(String value) async {
    await _secureStorage.write(key: ACCESS_TOKEN, value: value);
  }

  Future<String> getAccessToken() async {
    return await _secureStorage.read(key: ACCESS_TOKEN) ?? '';
  }

  Future<void> setRefreshToken(String value) async {
    await _secureStorage.write(key: REFRESH_TOKEN, value: value);
  }

  Future<String> getRefreshToken() async {
    return await _secureStorage.read(key: REFRESH_TOKEN) ?? '';
  }

  Future<void> setStudentId(String value) async {
    await _secureStorage.write(key: STUDENT_ID, value: value);
  }

  Future<int> getStudentId() async {
    return int.parse(await _secureStorage.read(key: STUDENT_ID) ?? '0');
  }

  Future<void> setStudentExternalId(String value) async {
    await _secureStorage.write(key: STUDENT_EXTERNAL_ID, value: value);
  }

  Future<int> getStudentExternalId() async {
    return int.parse(await _secureStorage.read(key: STUDENT_EXTERNAL_ID) ?? '0');
  }

  Future<void> setBranchId(String value) async {
    await _secureStorage.write(key: BRANCH_ID, value: value);
  }

  Future<int> getBranchId() async {
    return int.parse(await _secureStorage.read(key: BRANCH_ID) ?? '0');
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
