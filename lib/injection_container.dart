import 'package:booksapp/core/local_db/db_consumer.dart';
import 'package:booksapp/features/home/data/datasources/bookmark_localdb_datasource.dart';
import 'package:booksapp/features/home/data/datasources/books_localdb_datasource.dart';
import 'package:booksapp/features/home/data/datasources/books_remote_datasource.dart';
import 'package:booksapp/features/home/data/repositories/bookmark_repository_impl.dart';
import 'package:booksapp/features/home/data/repositories/books_repository_impl.dart';
import 'package:booksapp/features/home/domain/repositories/bookmark_repository.dart';
import 'package:booksapp/features/home/domain/repositories/books_repository.dart';
import 'package:booksapp/features/home/domain/usecases/add_bookmark_book.dart';
import 'package:booksapp/features/home/domain/usecases/delete_book.dart';
import 'package:booksapp/features/home/domain/usecases/get_book_by_id.dart';
import 'package:booksapp/features/home/domain/usecases/get_bookmarked_books.dart';
import 'package:booksapp/features/home/domain/usecases/get_books.dart';
import 'package:booksapp/features/home/domain/usecases/remove_bookmarked_book.dart';
import 'package:booksapp/features/home/presentation/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'core/api/api_consumer.dart';
import 'core/api/app_interceptor.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/metwork_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///Features

  //Blocs
  sl.registerFactory(() => HomeCubit(
      deleteBookByIdUseCase: sl(),
      getBooksUseCase: sl(),
      getBooksByIDUseCase: sl(),
      bookmarkBookUseCase: sl(),
      removeBookmarkedBookUseCase: sl(),
      getBookmarkedBooksUseCase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetBooks(repository: sl()));
  sl.registerLazySingleton(() => GetBooksById(repository: sl()));
  sl.registerLazySingleton(() => GetBookmarkedBooks(repository: sl()));
  sl.registerLazySingleton(() => AddBookmarkBook(repository: sl()));
  sl.registerLazySingleton(() => RemoveBookmarkedBook(repository: sl()));
  sl.registerLazySingleton(() => DeleteBookById(repository: sl()));

  //Repository
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
      networkInfo: sl(),
      booksRemoteDataSource: sl(),
      booksLocalDbDataSource: sl()));
  sl.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepositoryImpl(bookmarkLocalDbDataSource: sl()));
  //Data Sources
  sl.registerLazySingleton<BooksRemoteDataSource>(
      () => BooksRemoteDataSourceImpl(apiConsumer: sl(), dbDataSource: sl()));
  sl.registerLazySingleton<BooksLocalDbDataSource>(
      () => BooksLocalDbDataSourceImpl(dbConsumer: sl()));
  sl.registerLazySingleton<BookmarkLocalDbDataSource>(
      () => BookmarkLocalDataSourceImpl(dbConsumer: sl()));

  ///core
//networkinfo
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(conncectionCheker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
//Local DB
  sl.registerLazySingleton<DBConsumer>(() => DBConsumerImpl(db: sl()));

  ///external
  sl.registerLazySingleton(() => AppIntercepters());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => Dio());

  Database db = await databaseInit();
  sl.registerLazySingleton(() => db);
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
