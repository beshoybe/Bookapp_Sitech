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
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "cover": cover,
        "author": author,
        "description": description,
        "id": id.toString(),
      };
}
