part of 'images_cubit.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesInitial extends ImagesState {}

class ImagesLoadingState extends ImagesState {}

class ImagesLoadedState extends ImagesState {
  final List<ImageEntity> listImageEntity;

  const ImagesLoadedState(this.listImageEntity);
}

class ImagesFavoriteLoadingState extends ImagesState {}

class ImagesFavoriteLoadedState extends ImagesState {
  final List<ImageEntity> listImageEntity;

  const ImagesFavoriteLoadedState(this.listImageEntity);
}

class ImagesErrorState extends ImagesState {
  final String message;

  const ImagesErrorState({required this.message});
}

