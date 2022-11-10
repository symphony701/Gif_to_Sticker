import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GifService {
  Future<List<Gif>> getSearcherGif({String keyword = ''}) async {
    keyword = keyword.trim().replaceAll(' ', '_');
    final response = await http.get(
        Uri.parse(
            'https://tenor.googleapis.com/v2/search?q=$keyword&key=AIzaSyAz4plJnpG03g4J3BxSwquDvoiMLPEvwAs&client_key=GIFtoSticker&limit=100'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<Gif> gifs = jsonResponse['results']
          .map<Gif>((json) => Gif.fromJson(json))
          .toList();
      return gifs;
    } else {
      return [];
    }
  }
}
