import 'package:booksapp/core/errors/failures.dart';
import 'package:booksapp/core/usecases/usecases.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/repositories/bookmark_repository.dart';
import 'package:booksapp/features/home/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveBookmarkedBook implements UseCase<int, int> {
  final BookmarkRepository repository;

  RemoveBookmarkedBook({required this.repository});
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.removeBookmarkedBook(id: id);
  }
}
