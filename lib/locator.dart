import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'data/bookApiClient.dart';
import 'data/bookRepository.dart';

GetIt getIt= GetIt.instance;


void setupLocator(){
  getIt.registerLazySingleton<BookRepository>(() =>BookRepository());
  getIt.registerLazySingleton<BookApiClient>(() =>BookApiClient());
}