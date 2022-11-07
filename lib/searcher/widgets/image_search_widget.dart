import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';
import 'package:gif_to_sticker/searcher/widgets/inkk.dart';

class ImageSearch extends StatefulWidget {
  final Gif? data;
  final Function(Gif)? onTap;
  const ImageSearch({required this.data, required this.onTap, super.key});

  @override
  State<ImageSearch> createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  @override
  Widget build(BuildContext context) {
    return Inkk(
      onTap: () => widget.onTap!(widget.data!),
      child: Container(
        color: Colors.transparent,
        height: widget.data!.height!,
        child: Image.network(
          widget.data!.url!,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          },
        ),
      ),
    );
  }
}
