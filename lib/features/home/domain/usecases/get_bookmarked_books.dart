import 'package:booksapp/features/home/domain/repositories/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/book.dart';

class GetBookmarkedBooks implements UseCase<List<Book>, NoParams> {
  final BookmarkRepository repository;

  GetBookmarkedBooks({required this.repository});
  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) {
    return repository.getBookmarkedBooks();
  }
}
