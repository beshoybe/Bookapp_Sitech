import 'package:booksapp/core/errors/failures.dart';
import 'package:booksapp/core/local_db/db_consumer.dart';
import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/core/utils/images_manager.dart';
import 'package:booksapp/features/home/data/models/book_model.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

abstract class BooksLocalDbDataSource {
  Future<List<Book>> getSavedBooks();
  Future<int?> saveBook({required Book book});
  Future<int> clearSavedBook();
}

class BooksLocalDbDataSourceImpl implements BooksLocalDbDataSource {
  final DBConsumer dbConsumer;
  BooksLocalDbDataSourceImpl({required this.dbConsumer});

  @override
  Future<int> clearSavedBook() async {
    return await dbConsumer.delete(tableName: AppStrings.booksTable);
  }

  @override
  Future<List<Book>> getSavedBooks() async {
    List<Book> books = [];
    List response = await dbConsumer.get(tableName: AppStrings.booksTable);
    for (int i = 0; i < response.length; i++) {
      final Map<String, dynamic> newBook = Map.of(response[i]);
      newBook['id'] = newBook["id"].toString();
      books.add(BookModel.fromJson(newBook));
    }
    return books;
  }

  @override
  Future<int?> saveBook({required Book book}) async {
    return await dbConsumer.insert(
        tableName: AppStrings.booksTable, data: book.mapData);
  }
}
