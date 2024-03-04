import 'package:flickr/features/images/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  const ImageModel({required super.title, required super.url});
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      title: json["title"],
      url: json["url_c"] ?? "https://avatars.dzeninfra.ru/get-zen_doc/1950904/pub_5cc10e8cfad69800af105d4f_5cc1159f9a655700b38f27e5/scale_1200",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url_c': url,
    };
  }
}
