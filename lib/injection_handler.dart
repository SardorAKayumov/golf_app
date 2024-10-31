import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:golf_app/core/data/datasource/auth_data_source.dart';
import 'package:golf_app/core/data/repository/auth_repository_impl.dart';
import 'package:golf_app/core/domain/repository/auth_repository.dart';
import 'package:golf_app/core/domain/usecase/login_usecase.dart';
import 'package:golf_app/core/domain/usecase/refresh_token_usecase.dart';
import 'package:golf_app/core/domain/usecase/signup_usecase.dart';
import 'package:golf_app/core/services/auth_service.dart';
import 'package:golf_app/core/services/datetime_service.dart';
import 'package:golf_app/features/booking/booking.dart';
import 'package:golf_app/features/explore/explore.dart';

import 'core/local_storage/secure_storage.dart';
import 'core/local_storage/shared_pref.dart';
import 'core/network/base_api.dart';
import 'features/auth/login/bloc/login_bloc.dart';
import 'features/auth/signup/bloc/sign_up_bloc.dart';
import 'features/home/bloc/home_bloc.dart';

final GetIt di = GetIt.instance;

Future<void> setupDI() async {
  // Base API
  di.registerLazySingleton<BaseApi>(() => BaseApi());

  // Dio
  di.registerLazySingleton<Dio>(() => di.get<BaseApi>().dio);

  // Local Storage
  di.registerSingleton<SecureStorage>(SecureStorage());
  di.registerSingleton<MySharedPref>(MySharedPref());

  di.registerLazySingleton<DateTimeService>(() => DateTimeService(dio: di()));
  di.registerLazySingleton<AuthService>(() => AuthService(secureStorage: di()));

  // Data sources
  di.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(dio: di()));

  // Repository
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authDataSource: di(),
        secureStorage: di(),
      ));

  // Usecase
  di.registerLazySingleton<SignupUseCase>(() => SignupUseCase(repository: di()));
  di.registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: di()));
  di.registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(repository: di()));

  // Bloc
  di.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: di()));
  di.registerFactory<SignUpBloc>(() => SignUpBloc());
  di.registerFactory<HomeBloc>(() => HomeBloc());
  di.registerFactory<ExploreBloc>(() => ExploreBloc(sharedPref: di()));
  di.registerFactory<BookingBloc>(() => BookingBloc());
}
