import 'package:get_it/get_it.dart';
import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile/features/auth/domain/usecases/login_user.dart';
import 'package:mobile/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:mobile/features/auth/presentation/blocs/login_cubit.dart';
import 'package:mobile/features/auth/presentation/blocs/sign_up_bloc.dart';
import 'package:mobile/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Core
  sl.registerLazySingleton(() => ApiClient(baseUrl: dotenv.env['API_URL']!));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // Blocs
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => SignUpBloc(sl()));
  sl.registerFactory(() => OnboardingBloc());
}