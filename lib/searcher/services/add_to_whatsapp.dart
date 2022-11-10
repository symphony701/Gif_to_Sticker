import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/services/converter_service_native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';

Future<void> addToWhatsAppService(List<Gif> selectedGifs) async {
  var applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
  var stickersDirectory =
      Directory('${applicationDocumentsDirectory.path}/stickers');
  await stickersDirectory.create(recursive: true);
  final almacenatedGifs = [];
  for (var gif in selectedGifs) {
    final gifAlready = await convertMethodChannel(
        gif.url!, stickersDirectory.path, gif.nameFile!);
    almacenatedGifs.add(gifAlready);
  }

  var stickerPack = WhatsappStickers(
    identifier: 'gifsticker${DateTime.now().toString().replaceAll(':', '')}',
    name: 'Stickers Generated in GIFs to Stickers App',
    publisher: 'GIFs to Stickers',
    trayImageFileName: WhatsappStickerImage.fromAsset('assets/icon.png'),
    publisherWebsite: '',
    privacyPolicyWebsite: '',
    licenseAgreementWebsite: '',
  );

  for (var gifPath in almacenatedGifs) {
    stickerPack.addSticker(
      WhatsappStickerImage.fromFile("$gifPath"),
      ['😍', '♥'],
    );
  }
  try {
    await stickerPack.sendToWhatsApp();
  } on WhatsappStickersException catch (e) {
    throw Exception(e.cause);
  }

/*
  //final dio = Dio();
  final downloads = <Future>[];
  for (var gif in selectedGifs) {
    //downloads.add(dio.download(
    //gif.urlWebp!, '${stickersDirectory.path}/${gif.nameFile}'));
    print('DIRECTORI:::::::${stickersDirectory.path}/${gif.nameFile}');
  }
  await Future.wait(downloads);

  var stickerPack = WhatsappStickers(
    identifier: 'gifsticker${DateTime.now().toString().replaceAll(':', '')}',
    name: 'Stickers Generated in GIF to Sticker App',
    publisher: 'GIFs to Stickers',
    trayImageFileName: WhatsappStickerImage.fromAsset('assets/tray_Cuppy.png'),
    publisherWebsite: '',
    privacyPolicyWebsite: '',
    licenseAgreementWebsite: '',
  );

  for (var gif in selectedGifs) {
    stickerPack.addSticker(
      WhatsappStickerImage.fromFile(
          '${stickersDirectory.path}/${gif.nameFile}'),
      ['😍', '♥'],
    );
  }

  try {
    await stickerPack.sendToWhatsApp();
  } on WhatsappStickersException catch (e) {
    print(e);
    throw Exception(e.cause);
  }*/
}
