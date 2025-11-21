import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/product_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/catalog_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/catalog_repository.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // Firebase Auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data Sources
  getIt.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(
      getIt<ProductLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<FirebaseAuth>(),
    ),
  );
}
