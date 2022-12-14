import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:gif_to_sticker/searcher/services/add_to_whatsapp.dart';
import 'package:gif_to_sticker/searcher/widgets/add_to_whatsapp_widget.dart';
import 'package:gif_to_sticker/searcher/widgets/banner_ad.dart';
import 'package:gif_to_sticker/searcher/widgets/error_dialog.dart';
import 'package:gif_to_sticker/searcher/widgets/list_tile_gif.dart';
import 'package:gif_to_sticker/searcher/widgets/loading_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class SavedGifView extends StatefulWidget {
  const SavedGifView({super.key});

  @override
  State<SavedGifView> createState() => _SavedGifViewState();
}

class _SavedGifViewState extends State<SavedGifView> {
  final BannerAd searchViewBannerAd =
      myBanner('ca-app-pub-3940256099942544/6300978111');
  AdWidget? adWidget;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  bool _isInProcess = false;

  void _initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: '	ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isInterstitialAdReady = false;
          _interstitialAd.dispose();
        },
      ),
    );
  }

  @override
  void initState() {
    _initInterstitialAd();
    searchViewBannerAd.load();
    adWidget = AdWidget(ad: searchViewBannerAd);
    super.initState();
  }

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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: gifProvider.gifsCount == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 200,
                            child: Image.asset('assets/empty.webp')),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'No Selected GIFs',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: gifProvider.gifsCount,
                    itemBuilder: (context, index) {
                      return ListTileGif(gif: gifProvider.gifs[index]);
                    },
                  ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: adWidget,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (gifProvider.gifsCount < 3 && !_isInProcess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'You can only add 3 to 5 GIFs',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 53, 53, 53),
              ),
            );
          } else {
            try {
              setState(() {
                _isInProcess = true;
              });
              showDialog(
                  context: context,
                  builder: (_) => const LoadingDialog(),
                  barrierDismissible: false);
              List<Gif> gifs = gifProvider.gifs;
              if (_isInterstitialAdReady) {
                _interstitialAd.show();
              }
              await addToWhatsAppService(gifs);
              setState(() {
                _isInProcess = false;
              });
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              gifProvider.clearGifs();
            } catch (e) {
              Navigator.pop(context);
              setState(() {
                _isInProcess = false;
              });
              showDialog(
                  context: context,
                  builder: (_) => const ErrorDialog(),
                  barrierDismissible: false);
            }
          }
        },
        child: const AddToWhatsAppWidget(),
      ),
    );
  }
}
