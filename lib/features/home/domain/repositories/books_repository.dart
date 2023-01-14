import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getBooks({required int page});

  Future<Either<Failure, Book>> getBookById(
      {required int id, required CancelToken cancelToken});
  Future<Either<Failure, int>> deleteBookById({required int id});
}
