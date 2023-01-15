import '../../../../core/local_db/db_consumer.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/images_manager.dart';
import '../../domain/entities/book.dart';
import '../models/book_model.dart';

abstract class BookmarkLocalDbDataSource {
  Future<List<Book>> getBookmarkeBdooks();
  Future<int?> bookmarkBook({required Book book});
  Future<int> removeBookmarkBook({required int id});
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDbDataSource {
  final DBConsumer dbConsumer;
  BookmarkLocalDataSourceImpl({required this.dbConsumer});
  @override
  Future<int?> bookmarkBook({required Book book}) async {
    final Map<String, dynamic> newBook = Map.of(book.mapData);
    await ImagesManager.fileFromImageUrl(
            newBook[AppStrings.cover], newBook[AppStrings.id].toString())
        .then((value) {
      newBook[AppStrings.cover] = value.path;
    });
    return await dbConsumer.insert(
        tableName: AppStrings.bookmarksTable, data: newBook);
  }

  @override
  Future<List<Book>> getBookmarkeBdooks() async {
    List<Book> books = [];
    List response = await dbConsumer.get(tableName: AppStrings.bookmarksTable);
    response.forEach((element) {
      final Map<String, dynamic> newBook = Map.of(element);
      newBook[AppStrings.id] = newBook[AppStrings.id].toString();
      books.add(BookModel.fromJson(newBook));
    });
    return books;
  }

  @override
  Future<int> removeBookmarkBook({required int id}) async {
    return await dbConsumer.delete(
        tableName: AppStrings.bookmarksTable, where: "id=$id");
  }
}
