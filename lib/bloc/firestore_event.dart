import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FirestoreEvent extends Equatable {
  const FirestoreEvent();
}


class FetchBookImages extends FirestoreEvent{
  final String bookID;

  FetchBookImages({@required this.bookID});

  @override
  // TODO: implement props
  List<Object> get props => [bookID];


}

class FetchBookCover extends FirestoreEvent{
  @override
  // TODO: implement props
  List<Object> get props => null;
}
