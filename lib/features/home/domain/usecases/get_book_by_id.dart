import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/books_repository.dart';

class GetBooksById implements UseCase<Book, List> {
  final BookRepository repository;

  GetBooksById({required this.repository});
  @override
  Future<Either<Failure, Book>> call(List params) {
    return repository.getBookById(id: params[0], cancelToken: params[1]);
  }
}
