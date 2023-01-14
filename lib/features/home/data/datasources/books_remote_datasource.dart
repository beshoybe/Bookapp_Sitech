import 'package:booksapp/core/local_db/db_consumer.dart';
import 'package:booksapp/core/utils/app_strings.dart';
import 'package:booksapp/core/utils/images_manager.dart';
import 'package:booksapp/features/home/data/datasources/books_localdb_datasource.dart';
import 'package:booksapp/features/home/data/models/book_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/endpoints.dart';

abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getBooks({required int page});
  Future<BookModel> getBookById(
      {required int id, required CancelToken cancelToken});
  Future<void> deleteBookById({required int id});
}

class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  final ApiConsumer apiConsumer;
  final BooksLocalDbDataSource dbDataSource;
  BooksRemoteDataSourceImpl(
      {required this.apiConsumer, required this.dbDataSource});
  @override
  Future<List<BookModel>> getBooks({required int page}) async {
    final response = await apiConsumer.get(EndPoints.booksEndPoint,
        queryParameters: {"page": page, "limit": 10});
    List<BookModel> booksList = [];
    await response.forEach((item) async {
      booksList.add(BookModel.fromJson(item));

      final Map<String, dynamic> newBook = Map.of(item);

      await ImagesManager.fileFromImageUrl(newBook['cover'], newBook['id'])
          .then((value) {
        newBook['cover'] = value.path;
      });

      await dbDataSource.saveBook(book: BookModel.fromJson(newBook));
    });
    print(booksList.length);
    return booksList;
  }

  @override
  Future<BookModel> getBookById(
      {required int id, required CancelToken cancelToken}) async {
    final response = await apiConsumer.get("${EndPoints.booksEndPoint}/$id",
        cancleToken: cancelToken);
    BookModel model = BookModel.fromJson(response);

    return model;
  }

  @override
  Future<void> deleteBookById({required int id}) async {
    final response = await apiConsumer.delete("${EndPoints.booksEndPoint}/$id");
  }
}
