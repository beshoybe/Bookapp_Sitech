import 'dart:convert';

import 'package:booksapp/features/home/domain/entities/book.dart';

BookModel? bookModelFromJson(String str) =>
    BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel? data) => json.encode(data!.toJson());

class BookModel extends Book {
  final DateTime createdAt;
  final String name;
  final String cover;
  final String author;
  final String description;
  final int id;
  const BookModel({
    required this.createdAt,
    required this.name,
    required this.cover,
    required this.author,
    required this.description,
    required this.id,
  }) : super(
            author: author,
            cover: cover,
            createdAt: createdAt,
            id: id,
            name: name,
            description: description);

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        cover: json["cover"],
        author: json["author"],
        description: json["description"],
        id: int.parse(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "cover": cover,
        "author": author,
        "description": description,
        "id": id.toString(),
      };
}
