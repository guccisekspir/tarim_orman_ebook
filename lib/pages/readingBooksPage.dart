import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarim_orman_ebook/bloc/bloc.dart';
import 'package:tarim_orman_ebook/data/bookStrings.dart';
import 'package:tarim_orman_ebook/pages/readBookWidget.dart';

class ReadingBookPage extends StatefulWidget {
  @override
  _ReadingBookPageState createState() => _ReadingBookPageState();
}

class _ReadingBookPageState extends State<ReadingBookPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc = BlocProvider.of<FirestoreBloc>(context);
    return BlocBuilder(
      bloc: _bloc,
      // ignore: missing_return
      builder: (context, state) {
        if (state is InitialFirestoreState) {
          debugPrint("initiala girdim");
          _bloc.add(FetchBookImages(bookID: "bookcover"));
        } else if (state is BookLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BookLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridViewBook(state.images),
          );
        } else if (state is BookErrorState) {
          return Center(
            child: Text("Hata"),
          );
        }
        return Container(
          child: Text("Bune aq"),
        );
      },
    );
  }

  Widget GridViewBook(List<String> images) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Container(
                  width: 140,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    child: Card(
                      elevation: 10,
                      child: FadeInImage.assetNetwork(
                        // here `bytes` is a Uint8List containing the bytes for the in-memory image
                        placeholder: 'assets/loading.gif',
                        image: images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<FirestoreBloc>(
                                create: (context) => FirestoreBloc(),
                                child: ReadBookPage(
                                  bookChoice: bookNameFireList[index],
                                ))),
                      );
                    },
                  )),
              Text(
                bookNameList[index],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              )
            ],
          );
        });
  }
}
