import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/providers/gifs_provider.dart';
import 'package:gif_to_sticker/searcher/ui/gifs_searchers_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GifProvider>(create: (_) => GifProvider()),
        ],
        builder: (context, _) {
          return const MaterialApp(
            themeMode: ThemeMode.dark,
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            home: GifSearchView(),
          );
        });
  }
}
