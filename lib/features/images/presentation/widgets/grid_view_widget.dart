import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/presentation/widgets/image_detail_screen.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.crossAxisCount,
    required this.list,
  });

  final int crossAxisCount;
  final List<ImageEntity> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, childAspectRatio: 16 / 9),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 200,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    imageUrl: list[index].url,
                    imageTitle: list[index].title,
                    heroTag: "image$index",
                  ),
                ));
              },
              child: Hero(
                tag: "image$index",
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: list[index].url,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
