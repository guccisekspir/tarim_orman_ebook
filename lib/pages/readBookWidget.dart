import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:page_turn/page_turn.dart';
import 'package:tarim_orman_ebook/bloc/bloc.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'dart:math'as math;


class ReadBookPage extends StatefulWidget {
  final String bookChoice;

  const ReadBookPage({Key key, this.bookChoice}) : super(key: key);
  @override
  _ReadBookPageState createState() => _ReadBookPageState(bookChoice);
}

class _ReadBookPageState extends State<ReadBookPage> {
  final String bookChoicee;
  String _message = "";
  String _path = "";
  String _size = "";
  String _mimeType = "";
  File _imageFile;
  int _progress = 0;

  List<File> _mulitpleFiles = [];
  @override
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  _ReadBookPageState(this.bookChoicee);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc= BlocProvider.of<FirestoreBloc>(context);
    final _controller= GlobalKey<PageTurnState>();

    return Scaffold(
    resizeToAvoidBottomInset: false,

      body: BlocBuilder(
        bloc: _bloc,
        // ignore: missing_return
        builder: (context,FirestoreState state){
          if(state is InitialFirestoreState){
            _bloc.add(FetchBookImages(bookID: bookChoicee));
          }
          else if(state is BookLoadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is BookLoadedState){
            debugPrint("Girdik");

            return TransformerPageView(
                loop: false,
                transformer: new ZoomOutPageTransformer(),
                itemCount: state.images.length,

                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: state.images[index],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },

                );


          }
          else if(state is BookErrorState){
            return Center(child: Text("Hata oluştu"),);
          }
          return Center(child: Text("neaalakamak"),);
        },
      ),
    );
  }

}


class ZoomOutPageTransformer extends PageTransformer {
  static const double MIN_SCALE = 0.85;
  static const double MIN_ALPHA = 0.5;

  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position;
    double pageWidth = info.width;
    double pageHeight = info.height;

    if (position < -1) {
      // [-Infinity,-1)
      // This page is way off-screen to the left.
      //view.setAlpha(0);
    } else if (position <= 1) {
      // [-1,1]
      // Modify the default slide transition to
      // shrink the page as well
      double scaleFactor = math.max(MIN_SCALE, 1 - position.abs());
      double vertMargin = pageHeight * (1 - scaleFactor) / 2;
      double horzMargin = pageWidth * (1 - scaleFactor) / 2;
      double dx;
      if (position < 0) {
        dx = (horzMargin - vertMargin / 2);
      } else {
        dx = (-horzMargin + vertMargin / 2);
      }
      // Scale the page down (between MIN_SCALE and 1)
      double opacity = MIN_ALPHA +
          (scaleFactor - MIN_SCALE) / (1 - MIN_SCALE) * (1 - MIN_ALPHA);

      return new Opacity(
        opacity: opacity,
        child: new Transform.translate(
          offset: new Offset(dx, 0.0),
          child: new Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    } else {
      // (1,+Infinity]
      // This page is way off-screen to the right.
      // view.setAlpha(0);
    }

    return child;
  }
}

