import 'package:booksapp/features/home/data/datasources/bookmark_localdb_datasource.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDbDataSource bookmarkLocalDbDataSource;

  BookmarkRepositoryImpl({
    required this.bookmarkLocalDbDataSource,
  });
  @override
  Future<Either<Failure, List<Book>>> getBookmarkedBooks() async {
    try {
      final localBooks = await bookmarkLocalDbDataSource.getBookmarkeBdooks();
      return Right(localBooks);
    } on LocalDbException catch (exception) {
      return Left(LocalDbError(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, int>> bookmarkBook({required Book book}) async {
    try {
      final localBooks =
          await bookmarkLocalDbDataSource.bookmarkBook(book: book);
      return Right(1);
    } on LocalDbException catch (exception) {
      return Left(LocalDbError(message: exception.message!));
    }
  }

  @override
  Future<Either<Failure, int>> removeBookmarkedBook({required int id}) async {
    try {
      final localBooks =
          await bookmarkLocalDbDataSource.removeBookmarkBook(id: id);
      return Right(1);
    } on LocalDbException catch (exception) {
      return Left(LocalDbError(message: exception.message!));
    }
  }
}
