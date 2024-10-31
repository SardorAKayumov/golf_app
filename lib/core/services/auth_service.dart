
import '../local_storage/secure_storage.dart';
import 'navigation_service.dart';

class AuthService {
  final SecureStorage _secureStorage;

  AuthService({required secureStorage}) : _secureStorage = secureStorage;

  void logout() {
    _secureStorage
        .deleteAll()
        .then((_) => NavigationService.navigateToLogin());
  }
}
