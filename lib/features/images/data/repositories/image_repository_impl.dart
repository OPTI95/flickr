import 'package:dartz/dartz.dart';
import 'package:flickr/features/core/error/failure.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/domain/repositories/image_repository.dart';
import '../../../core/error/exception.dart';
import '../../../core/platform/network_info.dart';
import '../datasources/image_local_data_source.dart';
import '../datasources/image_remote_data_source.dart';
import '../models/image_model.dart';

class ImageRepositoryImpl extends ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  final ImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<ImageEntity>>> getImageSearch(
      String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListImages =
            await remoteDataSource.getImageSearch(query, page);
        localDataSource.cacheListImages(remoteListImages);
        return Right(remoteListImages);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListImages = await localDataSource.getLastListImages();
        return Right(localListImages);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<ImageEntity>>> getFavoriteListImages() async {
    try {
      final localListImages = await localDataSource.getFavoriteListImages();
      return Right(localListImages);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setFavorite(ImageEntity imageEntity) async {
    try {
      ImageModel imageModel = ImageModel(
        title: imageEntity.title,
        url: imageEntity.url,
      );
      final result = await localDataSource.cacheFavoriteImages(imageModel);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
