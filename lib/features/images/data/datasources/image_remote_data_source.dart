import 'dart:convert';
import 'package:flickr/features/images/data/models/image_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/exception.dart';

abstract class ImageRemoteDataSource {
  /// Calls the https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=e3f88e91fe36fb6fd61538eaa0e015c0&text=chechnya&per_page=40&page=2&media=photos&extras=url_o&license=1,2,3,4,5,6&format=json&nojsoncallback=1 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ImageModel>> getImageSearch(String query, int page);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final http.Client client;

  ImageRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ImageModel>> getImageSearch(String query, int page) async {
    try {
      String url =
          "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=e3f88e91fe36fb6fd61538eaa0e015c0&text=$query&per_page=40&page=$page&media=photos&extras=url_c&license=1,2,3,4,5,6&format=json&nojsoncallback=1";
      final response = await client.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List<dynamic> photos = jsonBody['photos']['photo'];
        return photos.map((photo) => ImageModel.fromJson(photo)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
