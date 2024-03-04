import 'package:dartz/dartz.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/domain/repositories/image_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';

class GetFavoriteListImages extends UseCase<List<ImageEntity>, NoParams> {
  final ImageRepository repository;
  GetFavoriteListImages(this.repository);

  @override
  Future<Either<Failure, List<ImageEntity>>> call(NoParams params) async {
    return await repository.getFavoriteListImages();
  }
}

