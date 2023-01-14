part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class SuccessLoadingAllBooksState extends HomeState {}

class LoadingAllBooksState extends HomeState {}

class ErrorLoadingAllBooksState extends HomeState {}

class SuccessLoadingMoreBooksState extends HomeState {}

class LoadingMoreAllBooksState extends HomeState {}

class SuccessReloadigAllBooksState extends HomeState {}

class ReloadingAllBooksState extends HomeState {}

class ShowFloaingChangeState extends HomeState {}

class HideFloaingChangeState extends HomeState {}

class GoUpState extends HomeState {}

class LoadingBooksByIdState extends HomeState {}

class ErrorLoadingBooksByIdState extends HomeState {}

class SuccessLoadingBooksByIdState extends HomeState {}

class ShowNoInternetState extends HomeState {}

class LoadingBookmarksState extends HomeState {}

class ErrorLoadingBookmarksState extends HomeState {}

class SuccessLoadingBookmarksState extends HomeState {}

class AddToBookmarkState extends HomeState {}

class RemoveBookmarkState extends HomeState {}

class LoadingDeleteBookState extends HomeState {}

class ErrorLoadingDeleteBookState extends HomeState {}

class SuccessLoadingDeleteBookState extends HomeState {}
