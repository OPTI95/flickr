import 'package:equatable/equatable.dart';

abstract class Exeption extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerException implements Exception {}

class CacheException implements Exception {}