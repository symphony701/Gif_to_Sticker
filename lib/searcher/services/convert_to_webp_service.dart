import 'dart:convert';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:http/http.dart' as http;

Future<String> convertToWebp(String gifUrl, double width, double height) async {
  try {
    String url = 'https://ezgif.com/gif-to-webp?url=$gifUrl';
    http.Request req = http.Request("Get", Uri.parse(url))
      ..followRedirects = false;
    http.Client baseClient = http.Client();
    http.StreamedResponse response = await baseClient.send(req);
    Uri redirectUri = Uri.parse(response.headers['location']!);
    String almacenatedGif = redirectUri.toString().substring(30);
    String instancia = almacenatedGif[6];

    final responsewebp = await http.post(
      Uri.parse(
          'https://s$instancia.ezgif.com/gif-to-webp/$almacenatedGif?ajax=true'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {"file": almacenatedGif, "lossy": "on"},
      encoding: Encoding.getByName('utf-8'),
    );

    String webpScrapper = responsewebp.body.toString();
    String almacenatedWebp = webpScrapper.substring(48, 72);

    final responseResize = await http.post(
      Uri.parse(
          'https://s$instancia.ezgif.com/resize/$almacenatedWebp?ajax=true'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "file": almacenatedWebp,
        "old_width": '${width.toInt()}',
        "old_height": '${height.toInt()}',
        "width": '${512}',
        "height": '${512}',
        "percentage": '${100}',
        "method": "im-coalesce",
        "ar": "crop"
      },
      encoding: Encoding.getByName('utf-8'),
    );

    String scrapperResize = responseResize.body.toString();
    String linkwebp = scrapperResize.substring(29, 72);
    linkwebp = 'https:$linkwebp';

    print('Webp link: $linkwebp');

    return linkwebp;
  } catch (e) {
    throw Exception(e);
  }
}

Future<List<Gif>> gifConverted(List<Gif> gifsSelected) async {
  for (var gif in gifsSelected) {
    gif.urlWebp =
        await convertToWebp(gif.url!, gif.mediumWidth!, gif.mediumHeight!);
    print(gif.urlWebp);
  }
  return gifsSelected;
}
