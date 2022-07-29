import 'package:flutter/material.dart';
import 'package:svg_parser/src/models/svg_obj.dart';
import 'package:svg_parser/src/parser.dart';

class SvgViewer extends StatefulWidget {
  const SvgViewer({
    super.key,
    required this.parser,
  });

  final SvgParser parser;

  @override
  State<SvgViewer> createState() => _SvgViewerState();
}

class _SvgViewerState extends State<SvgViewer> {
  List<SvgObject> items = [];

  List<SvgObject> getElements() {
    items.clear();
    final rects = widget.parser.getRects();
    final text = widget.parser.getText();
    List<SvgObject> objs = [];
    for (var i = 0; i < rects.length; i++) {
      objs.add(SvgObject(rects[i], text[i]));
    }

    return objs;
  }

  @override
  Widget build(BuildContext context) {
    items = getElements();
    final picture = widget.parser.getImage();
    return Stack(
      children: [
        Positioned.fill(
          child: Image.memory(
            picture.image,
            width: picture.width,
            height: picture.height,
            fit: BoxFit.fill,
          ),
        ),
        ...items
            .map(
              (e) => Positioned(
                top: e.rect.y,
                left: e.rect.x,
                child: Container(
                  alignment: Alignment.center,
                  width: e.rect.width,
                  height: e.rect.height,
                  color: Colors.black,
                  child: Text(
                    e.text.child,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
