import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:gif_to_sticker/searcher/services/gift_service.dart';
import 'package:gif_to_sticker/searcher/widgets/appbar_icon.dart';
import 'package:gif_to_sticker/searcher/widgets/image_search_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stream_transform/stream_transform.dart';

class GifSearchView extends StatefulWidget {
  const GifSearchView({super.key});

  @override
  State<GifSearchView> createState() => _GifSearchViewState();
}

class _GifSearchViewState extends State<GifSearchView> {
  List<Gif> gifs = [];
  final scrollController = ScrollController();
  StreamController<String> streamController = StreamController();

  Future<void> _fetchGifs(String keyword) async {
    GifService service = GifService();
    if (gifs.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
    gifs = await service.getSearcherGif(keyword: keyword);
    setState(() {});
  }

  @override
  void initState() {
    streamController.stream
        .debounce(const Duration(seconds: 1))
        .listen((value) => {
              if (value.isNotEmpty)
                {_fetchGifs(value.toString())}
              else if (value.isEmpty)
                {
                  setState(() {
                    gifs = [];
                  })
                }
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GifProvider gifProvider = Provider.of<GifProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(96, 53, 53, 53),
      resizeToAvoidBottomInset: false,
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
        actions: const [
          AppBarIcon(),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              onChanged: (value) {
                streamController.add(value);
              },
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusColor: Colors.white,
                fillColor: Colors.white,
                hintText: 'Type something...',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Search GIFs powered by',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' Tenor',
                  style: GoogleFonts.poppins(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: gifs.isNotEmpty
                ? MasonryGridView.count(
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    itemCount: gifs.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      return ImageSearch(
                        data: gifs[index],
                        onTap: (singleGif) {
                          if (gifProvider.gifsCount < 5) {
                            gifProvider.addGif(singleGif);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'You can only add 3 to 5 GIFs',
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 53, 53, 53),
                              ),
                            );
                          }
                        },
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/nosearch.webp',
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'No GIFs Searcher',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
