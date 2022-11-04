import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';

class GifProvider with ChangeNotifier {
  final List<Gif> _gifs = [];

  List<Gif> get gifs => _gifs;
  int get gifsCount => _gifs.length;

  void addGif(Gif gif) {
    _gifs.add(gif);
    notifyListeners();
  }

  void removeGif(Gif gif) {
    _gifs.remove(gif);
    notifyListeners();
  }
}
