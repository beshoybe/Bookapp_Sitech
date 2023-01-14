import 'package:booksapp/core/errors/failures.dart';
import 'package:booksapp/core/usecases/usecases.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/repositories/bookmark_repository.dart';
import 'package:booksapp/features/home/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class AddBookmarkBook implements UseCase<int, Book> {
  final BookmarkRepository repository;

  AddBookmarkBook({required this.repository});
  @override
  Future<Either<Failure, int>> call(Book book) {
    return repository.bookmarkBook(book: book);
  }
}
