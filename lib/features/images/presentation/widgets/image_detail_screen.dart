import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickr/features/images/domain/entities/image_entity.dart';
import 'package:flickr/features/images/presentation/cubit/images_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  final String heroTag;

  const ImageDetailScreen({
    super.key,
    required this.imageUrl,
    required this.imageTitle,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageTitle),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Hero(
              tag: heroTag,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  onPressed: () async {
                    bool ans = await context
                        .read<ImagesCubit>()
                        .setFavoriteImage(
                            ImageEntity(title: imageTitle, url: imageUrl));
                    if (ans) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Успешно добавил")));
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Уже есть")));
                    }
                  },
                  child: const Text("Добавить в избранное")),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
