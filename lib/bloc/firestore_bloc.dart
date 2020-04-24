import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tarim_orman_ebook/data/bookRepository.dart';
import 'package:tarim_orman_ebook/locator.dart';

import './bloc.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  @override
  FirestoreState get initialState => InitialFirestoreState();
  final bookRepository = getIt<BookRepository>();

  @override
  Stream<FirestoreState> mapEventToState(
    FirestoreEvent event,
  ) async* {
    if (event is FetchBookImages) {
      yield BookLoadingState();
      debugPrint("bloc");
      try {
        String bookID = event.bookID;
        List<String> images = await bookRepository.getImages(bookID);

        yield BookLoadedState(images: images);
      } catch (_) {
        debugPrint("hataa");
        debugPrint(_.toString());
        yield BookErrorState();
      }
    }
  }
}
