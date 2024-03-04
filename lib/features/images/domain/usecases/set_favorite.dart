import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/domain/repositories/image_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/usecase.dart';

class SetFavorite extends UseCase<bool, ImaParams> {
  final ImageRepository repository;
  SetFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(ImaParams params) async {
    return await repository.setFavorite(params.imageEntity);
  }
}

class ImaParams extends Equatable {
  final ImageEntity imageEntity ;
  const ImaParams({required this.imageEntity});

  @override
  List<Object?> get props => [imageEntity];
}
