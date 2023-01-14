import 'dart:math';

import 'package:booksapp/core/utils/constants.dart';
import 'package:booksapp/features/home/data/datasources/books_localdb_datasource.dart';
import 'package:booksapp/features/home/data/datasources/books_remote_datasource.dart';
import 'package:booksapp/features/home/data/models/book_model.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/metwork_info.dart';

class BookRepositoryImpl implements BookRepository {
  final NetworkInfo networkInfo;
  final BooksRemoteDataSource booksRemoteDataSource;
  final BooksLocalDbDataSource booksLocalDbDataSource;
  BookRepositoryImpl(
      {required this.networkInfo,
      required this.booksRemoteDataSource,
      required this.booksLocalDbDataSource});
  @override
  Future<Either<Failure, List<Book>>> getBooks({required int page}) async {
    if (await networkInfo.isConnected) {
      if (page == 1) {
        booksLocalDbDataSource.clearSavedBook();
      }
      try {
        final remoteBooks = await booksRemoteDataSource.getBooks(page: page);
        return Right(remoteBooks);
      } on ServerException catch (exception) {
        return Left(ServerError(message: exception.toString()));
      }
    } else {
      Constants.toastShow(message: "No Internet Connection");
      if (page == 1) {
        try {
          final localBooks = await booksLocalDbDataSource.getSavedBooks();
          return localBooks.isEmpty
              ? Left(LocalDbError(message: NoDataFoundException().message!))
              : Right(localBooks);
        } on LocalDbException catch (exception) {
          return Left(LocalDbError(message: exception.message!));
        }
      } else {
        return Right([]);
      }
    }
  }

  @override
  Future<Either<Failure, Book>> getBookById(
      {required int id, required CancelToken cancelToken}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await booksRemoteDataSource.getBookById(
            id: id, cancelToken: cancelToken);
        return Right(remoteNews);
      } on ServerException catch (exception) {
        return Left(ServerError(message: exception.toString()));
      }
    } else {
      return Left(
          ServerError(message: NoInternetConnectionException().message!));
    }
  }

  @override
  Future<Either<Failure, int>> deleteBookById({required int id}) async {
    try {
      final response = await booksRemoteDataSource.deleteBookById(id: id);
      return Right(1);
    } on ServerException catch (exception) {
      return Left(ServerError(message: exception.toString()));
    }
  }
}
