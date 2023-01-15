import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, List<Book>>> getBookmarkedBooks();
  Future<Either<Failure, int>> bookmarkBook({required Book book});
  Future<Either<Failure, int>> removeBookmarkedBook({required int id});
}
