import 'dart:convert';

import 'package:flickr/features/images/data/models/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exception.dart';

// ignore: constant_identifier_names
const CACHED_IMAGE = 'CACHED_IMAGE';
// ignore: constant_identifier_names
const CACHED_FAVORITE_IMAGE = 'CACHED_FAVORITE_IMAGE';

abstract class ImageLocalDataSource {
  Future<List<ImageModel>> getLastListImages();
  Future<List<ImageModel>> getFavoriteListImages();
  Future<void> cacheListImages(List<ImageModel> imageModel);
  Future<bool> cacheFavoriteImages(ImageModel imageModel);
}

class ImageLocalDataSourceImpl implements ImageLocalDataSource {
  final SharedPreferences sharedPreferences;

  ImageLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheListImages(List<ImageModel> imagesToCache) async {
    final List<Map<String, dynamic>> jsonList =
        imagesToCache.map((imageModel) => imageModel.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await sharedPreferences.setString(CACHED_IMAGE, jsonString);
  }

  @override
  Future<List<ImageModel>> getLastListImages() async {
    final jsonString = sharedPreferences.getString(CACHED_IMAGE);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> cacheFavoriteImages(ImageModel imageModel) async {
    List<ImageModel> existingFavorites = await getFavoriteListImages();
    bool alreadyExists =
        existingFavorites.any((element) => element.url == imageModel.url);
    if (!alreadyExists) {
      existingFavorites.add(imageModel);
      final List<Map<String, dynamic>> jsonList =
          existingFavorites.map((imageModel) => imageModel.toJson()).toList();
      final String jsonString = json.encode(jsonList);
      await sharedPreferences.setString(CACHED_FAVORITE_IMAGE, jsonString);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<ImageModel>> getFavoriteListImages() async {
    final jsonString = sharedPreferences.getString(CACHED_FAVORITE_IMAGE);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      final List<ImageModel> newFavoritesList = [];
      return newFavoritesList;
    }
  }
}
