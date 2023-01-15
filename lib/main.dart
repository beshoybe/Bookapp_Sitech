import 'package:bloc/bloc.dart';
import 'package:booksapp/app.dart';
import 'package:flutter/material.dart';
import 'bloc_observer.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(const BooksApp());
}
