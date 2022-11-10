import 'package:flutter/services.dart';

Future<String> convertMethodChannel(
    String urlGif, String pathDownload, String nameFile) async {
  const converterChannel = MethodChannel('com.giftosticker.rn/converter');
  final result = await converterChannel.invokeMethod('gifConverter', {
    'urlGif': urlGif,
    'pathDownload': pathDownload,
    'nameFile': nameFile,
  });
  return result.toString();
}
