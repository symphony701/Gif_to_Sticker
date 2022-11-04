import 'package:flutter/material.dart';
import 'package:gif_to_sticker/searcher/models/gif_model.dart';

class ImageSearch extends StatefulWidget {
  final Gif? data;
  final Function(Gif)? onTap;
  final Function(Gif)? onDelete;
  const ImageSearch(
      {required this.data,
      required this.onTap,
      required this.onDelete,
      super.key});

  @override
  State<ImageSearch> createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !isAdded ? widget.onTap!(widget.data!) : widget.onDelete!(widget.data!);
        setState(() {
          isAdded = !isAdded;
        });
      },
      child: Container(
        color: Colors.transparent,
        height: widget.data!.height,
        child: Stack(
          children: [
            Image.network(
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
            Container(
              width: double.infinity,
              height: double.infinity,
              color: isAdded
                  ? const Color.fromARGB(78, 0, 187, 212)
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
