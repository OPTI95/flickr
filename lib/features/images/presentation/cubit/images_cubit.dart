import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flickr/features/core/error/failure.dart';
import 'package:flickr/features/core/usecase/usecase.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/domain/usecases/get_favorite_list_images.dart';
import 'package:flickr/features/images/domain/usecases/get_image_search.dart';
import 'package:flickr/features/images/domain/usecases/set_favorite.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  final GetImageSearch getImageSearch;
  final SetFavorite setFavorite;
  final GetFavoriteListImages getFavoriteListImages;
  ImagesCubit(
      {required this.getImageSearch,
      required this.setFavorite,
      required this.getFavoriteListImages})
      : super(ImagesInitial());
  Future<void> fetchImageSearch(String query, int page) async {
    try {
      emit(ImagesLoadingState());
      final loadedListImageOrFailure =
          await getImageSearch(ImageParams(query: query, page: page));
      loadedListImageOrFailure.fold(
          (error) => emit(ImagesErrorState(
              message: error is ServerFailure
                  ? "Проблема с получением данных с сервера"
                  : "Проблема с получением данных из хранилища")),
          (imagesEntity) {
        emit(ImagesLoadedState(imagesEntity));
      });
    } catch (_) {}
  }

  Future<void> fetchFavoriteList() async {
    try {
      emit(ImagesFavoriteLoadingState());
      final loadedListImageOrFailure =
          await getFavoriteListImages(NoParams());
      loadedListImageOrFailure.fold(
          (error) => emit(ImagesErrorState(
              message: error is ServerFailure
                  ? "Проблема с получением данных с сервера"
                  : "Проблема с получением данных из хранилища")),
          (imagesEntity) {
        emit(ImagesFavoriteLoadedState(imagesEntity));
      });
    } catch (_) {}
  }

  Future<bool> setFavoriteImage(ImageEntity imageEntity) async {
    bool ans = false;
    try {
      final loadedSetImageOrFailure =
          await setFavorite(ImaParams(imageEntity: imageEntity));
      loadedSetImageOrFailure.fold(
          (error) => emit(ImagesErrorState(
              message: error is ServerFailure
                  ? "Проблема с получением данных с сервера"
                  : "Проблема с получением данных из хранилища")),
          (boolAnswer) {
        ans = boolAnswer;
      });
      return ans;
    } catch (_) {
      return ans;
    }
  }
}
