import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/books_repository.dart';

class DeleteBookById implements UseCase<int, int> {
  final BookRepository repository;

  DeleteBookById({required this.repository});
  @override
  Future<Either<Failure, int>> call(int id) {
    return repository.deleteBookById(id: id);
  }
}
