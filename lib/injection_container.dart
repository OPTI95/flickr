import 'package:flickr/features/images/data/datasources/image_remote_data_source.dart';
import 'package:flickr/features/images/data/repositories/image_repository_impl.dart';
import 'package:flickr/features/images/domain/repositories/image_repository.dart';
import 'package:flickr/features/images/domain/usecases/get_favorite_list_images.dart';
import 'package:flickr/features/images/domain/usecases/get_image_search.dart';
import 'package:flickr/features/images/domain/usecases/set_favorite.dart';
import 'package:flickr/features/images/presentation/cubit/images_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/core/platform/network_info.dart';
import 'features/images/data/datasources/image_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => ImagesCubit(
      getImageSearch: sl(),
      setFavorite: sl(),
      getFavoriteListImages: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetImageSearch(sl()));
  sl.registerLazySingleton(() => SetFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoriteListImages(sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ImageLocalDataSource>(
    () => ImageLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

void initFeatures() {}
