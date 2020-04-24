import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarim_orman_ebook/bloc/bloc.dart';
import 'package:tarim_orman_ebook/pages/readingBooksPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    MediaQuery.of(context).size.height /
                        14), // here the desired height

                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white10,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Okuma Kitapları",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text("Boyama Kitapları",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
              body: BlocProvider<FirestoreBloc>(
                create: (context) => FirestoreBloc(),
                child: TabBarView(
                  children: [
                    ReadingBookPage(),
                    Icon(Icons.event),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
