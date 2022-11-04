import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:gif_to_sticker/searcher/services/add_to_whatsapp.dart';
import 'package:gif_to_sticker/searcher/services/convert_to_webp_service.dart';
import 'package:gif_to_sticker/searcher/widgets/list_tile_gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SavedGifView extends StatelessWidget {
  const SavedGifView({super.key});

  @override
  Widget build(BuildContext context) {
    GifProvider gifProvider = Provider.of<GifProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(96, 53, 53, 53),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GIFto',
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Text(
              'Sticker',
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.cyan),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: gifProvider.gifsCount,
        itemBuilder: (context, index) {
          return ListTileGif(gif: gifProvider.gifs[index]);
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.cyan,
        ),
        child: IconButton(
            color: Colors.white,
            onPressed: () async {
              List<Gif> gifs = gifProvider.gifs;
              gifs = await gifConverted(gifs);
              await addToWhatsAppService(gifs);
            },
            icon: const Icon(Icons.whatsapp_outlined)),
      ),
    );
  }
}
