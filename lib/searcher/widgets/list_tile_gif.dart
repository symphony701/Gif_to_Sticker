import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListTileGif extends StatelessWidget {
  final Gif? gif;

  const ListTileGif({required this.gif, super.key});

  @override
  Widget build(BuildContext context) {
    GifProvider gifProvider = Provider.of<GifProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: Image.network(gif!.nanoUrl!),
        title: Text(
          gif!.name!,
          style: GoogleFonts.poppins(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          onPressed: () => gifProvider.removeGif(gif!),
          icon: const Icon(Icons.delete, color: Colors.cyan),
        ),
      ),
    );
  }
}
