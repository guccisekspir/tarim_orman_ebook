import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class BookApiClient {
  static const baseURL =
      "https://firebasestorage.googleapis.com/v0/b/ormanbakanligikitap.appspot.com/o/";

  Future<List<String>> getImages(String bookID) async {
    List<String> imageUrls = [];
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child("/$bookID");
    StorageReference istenenImage;
    String downloadURL;
    for (int i = 1; i < 7; i++) {
      istenenImage = firebaseStorage.child("$i.png");
      downloadURL = await istenenImage.getDownloadURL();
      imageUrls.add(downloadURL);
    }
    return imageUrls;
  }
}
