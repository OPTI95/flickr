import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/images_cubit.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/grid_view_widget.dart';
import '../widgets/initial_widget.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  int crossAxisCount = 1;
  final TextEditingController searchController = TextEditingController();
  int page = 1;
  String lastText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBarWidget(
          changeGrid: changeGrid, searchController: searchController),
      body: BlocBuilder<ImagesCubit, ImagesState>(builder: (context, state) {
        if (state is ImagesInitial) {
          return const InitialWidget(
            text: "Можно найти все",
          );
        } else if (state is ImagesLoadingState ||
            state is ImagesFavoriteLoadingState) {
          return const InitialWidget(
            text: "Получаем изображения...",
          );
        } else if (state is ImagesLoadedState) {
          return RefreshIndicator(
            onRefresh: () async {
              if (lastText != searchController.text) {
                page = 1;
              }
              lastText = searchController.text;
              context
                  .read<ImagesCubit>()
                  .fetchImageSearch(searchController.text, page += 1);
            },
            child: GridViewWidget(
              crossAxisCount: crossAxisCount,
              list: state.listImageEntity,
            ),
          );
        } else if (state is ImagesFavoriteLoadedState) {
          return GridViewWidget(
            crossAxisCount: crossAxisCount,
            list: state.listImageEntity,
          );
        } else {
          return const InitialWidget(
            text: "Не удалось найти? Попробуйте изменить запрос",
          );
        }
      }),
    );
  }

  void changeGrid() {
    if (crossAxisCount == 1) {
      crossAxisCount = 2;
    } else if (crossAxisCount == 2) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 1;
    }
    setState(() {});
  }
}
