import 'package:dartz/dartz.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import '../../../core/error/failure.dart';

abstract class ImageRepository {
  Future<Either<Failure, List<ImageEntity>>> getImageSearch(String query, int page);
  Future<Either<Failure, bool>> setFavorite(ImageEntity imageEntity);
  Future<Either<Failure, List<ImageEntity>>> getFavoriteListImages();

}
