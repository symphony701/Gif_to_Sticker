import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:gif_to_sticker/searcher/ui/saved_gifs_view.dart';
import 'package:provider/provider.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    GifProvider gifProvider = Provider.of<GifProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.gif),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => const SavedGifView())),
              );
            },
          ),
          gifProvider.gifsCount > 0
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${gifProvider.gifsCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
