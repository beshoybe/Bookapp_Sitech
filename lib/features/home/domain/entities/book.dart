import 'package:booksapp/core/utils/app_strings.dart';
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final DateTime createdAt;
  final String name;
  final String cover;
  final String author;
  final String description;
  final int id;
  const Book({
    required this.createdAt,
    required this.name,
    required this.cover,
    required this.author,
    required this.description,
    required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [createdAt, name, cover, author, description, id];
  Map<String, Object?> get mapData => {
        AppStrings.createdAt: createdAt.toIso8601String(),
        AppStrings.name: name,
        AppStrings.cover: cover,
        AppStrings.author: author,
        AppStrings.description: description,
        AppStrings.id: id.toString(),
      };
}
