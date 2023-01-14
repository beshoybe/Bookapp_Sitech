import 'package:booksapp/core/errors/failures.dart';
import 'package:booksapp/core/usecases/usecases.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooks implements UseCase<List<Book>, int> {
  final BookRepository repository;

  GetBooks({required this.repository});
  @override
  Future<Either<Failure, List<Book>>> call(int page) {
    return repository.getBooks(page: page);
  }
}
