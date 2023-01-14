import 'package:booksapp/core/usecases/usecases.dart';
import 'package:booksapp/core/utils/constants.dart';
import 'package:booksapp/features/home/domain/entities/book.dart';
import 'package:booksapp/features/home/domain/usecases/add_bookmark_book.dart';
import 'package:booksapp/features/home/domain/usecases/delete_book.dart';
import 'package:booksapp/features/home/domain/usecases/get_book_by_id.dart';
import 'package:booksapp/features/home/domain/usecases/get_bookmarked_books.dart';
import 'package:booksapp/features/home/domain/usecases/get_books.dart';
import 'package:booksapp/features/home/domain/usecases/remove_bookmarked_book.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/thread_checking.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBooks getBooksUseCase;
  final GetBooksById getBooksByIDUseCase;
  final GetBookmarkedBooks getBookmarkedBooksUseCase;
  final AddBookmarkBook bookmarkBookUseCase;
  final RemoveBookmarkedBook removeBookmarkedBookUseCase;
  final DeleteBookById deleteBookByIdUseCase;
  HomeCubit(
      {required this.getBookmarkedBooksUseCase,
      required this.deleteBookByIdUseCase,
      required this.removeBookmarkedBookUseCase,
      required this.bookmarkBookUseCase,
      required this.getBooksUseCase,
      required this.getBooksByIDUseCase})
      : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  int page = 1;
  List<Book> allBooks = [];
  List<Book> bookmarkedBooks = [];
  bool isLoading = false;
  bool isReloading = false;
  bool isLoadingMore = false;
  bool showFloatingAction = false;
  bool isLoadingBook = false;
  Book? currentBook;
  bool errorOcurred = false;
  bool gettingBookMark = false;
  bool isBookmarked = false;
  final ScrollController listViewController = ScrollController();
  int? selectedBook;
  Future<void> getBooks() async {
    print("page is $page");
    isLoading = true;
    errorOcurred = false;
    emit(LoadingAllBooksState());
    Either<Failure, List<Book>> response = await getBooksUseCase(page);
    response.fold((failure) {
      Constants.toastShow(message: failure.message);
      errorOcurred = true;
      isLoading = false;
      page > 1 ? page -= 1 : null;
      emit(ErrorLoadingAllBooksState());
    }, (books) {
      if (books.isEmpty && page > 1) {
        page -= 1;
        Constants.toastShow(message: "No more books", failed: false);
      } else if (allBooks.isNotEmpty && page == 1) {
        allBooks.clear();
        Constants.toastShow(message: "Reload Successfully", failed: false);
      } else if (allBooks.isNotEmpty && page > 1) {
        Constants.toastShow(message: "Loaded More Successfully", failed: false);
      }
      allBooks.addAll(books);
      isLoading = false;
      emit(SuccessLoadingAllBooksState());
    });
  }

  Future<void> loadMore() async {
    if (!isLoading && !isLoadingMore) {
      isLoadingMore = true;
      emit(LoadingMoreAllBooksState());
      page += 1;
      await getBooks();
      isLoadingMore = false;
      emit(SuccessLoadingMoreBooksState());
    }
  }

  Future<void> reloadBooks() async {
    if (!isLoading && !isReloading) {
      isReloading = true;
      emit(ReloadingAllBooksState());
      page = 1;
      await getBooks();
      isReloading = false;
      emit(SuccessReloadigAllBooksState());
    }
  }

  void showFloating() {
    showFloatingAction = true;
    emit(ShowFloaingChangeState());
  }

  void hideFloating() {
    showFloatingAction = false;
    emit(HideFloaingChangeState());
  }

  void goToUp() {
    listViewController.animateTo(listViewController.initialScrollOffset,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    emit(GoUpState());
  }

  void getBookById(int id, CancelToken cancelToken) async {
    isLoadingBook = true;
    currentBook = null;
    emit(LoadingBooksByIdState());
    Either<Failure, Book> response =
        await getBooksByIDUseCase([id, cancelToken]);
    response.fold((failure) {
      isLoadingBook = false;
      emit(ErrorLoadingBooksByIdState());

      return null;
    }, (book) {
      isLoadingBook = false;
      currentBook = book;
      checkIsBookmarked(book);

      emit(SuccessLoadingBooksByIdState());
    });
  }

  void connectionCheckThread() async {
    print("Start check");
    await FlutterIsolate.spawn(checkConnectivity, 2);
  }

  void getBookmarkedBooks() async {
    gettingBookMark = true;
    emit(LoadingBookmarksState());
    Either<Failure, List<Book>> response =
        await getBookmarkedBooksUseCase(NoParams());
    response.fold((failure) {
      Constants.toastShow(message: "Error Occured", failed: true);
      gettingBookMark = false;
      emit(ErrorLoadingBookmarksState());
    }, (books) {
      bookmarkedBooks = books;
      gettingBookMark = false;
      emit(SuccessLoadingBookmarksState());
    });
  }

  void bookmarkBook(Book book) async {
    print("Saving bookmark");
    isBookmarked = true;
    emit(AddToBookmarkState());
    await bookmarkBookUseCase(book).then((value) {
      getBookmarkedBooks();
    });
  }

  void removeBookmark(int id) async {
    print("Removing bookmark");
    isBookmarked = false;
    emit(RemoveBookmarkState());
    await removeBookmarkedBookUseCase(id).then((value) {
      getBookmarkedBooks();
    });
  }

  void checkIsBookmarked(Book book) {
    for (int i = 0; i < bookmarkedBooks.length; i++) {
      if (bookmarkedBooks[i].id == book.id) {
        isBookmarked = true;
        break;
      } else {
        isBookmarked = false;
      }
    }
  }

  void deleteBookById(int id, BuildContext context) async {
    Navigator.pop(context);
    isLoading = true;
    emit(LoadingDeleteBookState());
    await deleteBookByIdUseCase(id).then((value) {
      value.fold((failure) {
        Constants.toastShow(message: "Error Deleting Book", failed: true);
        isLoading = false;
        emit(ErrorLoadingDeleteBookState());
      }, (r) async {
        if (isBookmarked) {
          removeBookmark(id);
        }
        Constants.toastShow(message: "Book Deleted Successfuly", failed: false);
        page = 1;
        getBooks();
      });
    });
  }
}
