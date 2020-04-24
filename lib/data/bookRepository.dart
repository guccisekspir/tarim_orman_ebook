import 'package:flutter/cupertino.dart';
import 'package:tarim_orman_ebook/locator.dart';
import 'bookApiClient.dart';

class BookRepository {
  BookApiClient bookApiClient = getIt<BookApiClient>();

  Future<List<String>> getImages(String bookID) async {
    var anan = await bookApiClient.getImages(bookID);
    return anan;
  }
}
