import 'package:flickr/features/images/presentation/cubit/images_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function changeGrid;
  final TextEditingController searchController;
  const AppBarWidget(
      {super.key, required this.changeGrid, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Поиск изображений",
                  hintStyle: const TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await context
                          .read<ImagesCubit>()
                          .fetchImageSearch(searchController.text, 1);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () => changeGrid(), icon: const Icon(Icons.apps)),
            IconButton(
                onPressed: () => context.read<ImagesCubit>().fetchFavoriteList(), 
                icon: const Icon(Icons.favorite))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
