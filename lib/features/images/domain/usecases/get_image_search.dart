import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/domain/repositories/image_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';

class GetImageSearch extends UseCase<List<ImageEntity>, ImageParams> {
  final ImageRepository repository;
  GetImageSearch(this.repository);

  @override
  Future<Either<Failure, List<ImageEntity>>> call(ImageParams params) async {
    return await repository.getImageSearch(params.query, params.page);
  }
}

class ImageParams extends Equatable {
  final String query;
  final int page;
  const ImageParams({required this.query, required this.page});

  @override
  List<Object?> get props => [query];
}
