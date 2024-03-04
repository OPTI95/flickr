import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String title;
  final String url;

  const ImageEntity({required this.title, required this.url});

  @override
  List<Object?> get props => [title, url];
}
