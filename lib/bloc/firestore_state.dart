import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class FirestoreState extends Equatable {
  const FirestoreState();
}

class InitialFirestoreState extends FirestoreState {
  @override
  List<Object> get props => [];
}

class BookLoadingState extends FirestoreState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class BookLoadedState extends FirestoreState {
  final List<String> images;

  BookLoadedState({@required this.images});

  @override
  // TODO: implement props
  List<Object> get props => [images];
}

class BookErrorState extends FirestoreState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
