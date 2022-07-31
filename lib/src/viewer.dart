import 'package:flutter/material.dart';
import 'package:svg_parser/src/models/svg_obj.dart';
import 'package:svg_parser/src/parser.dart';
import 'package:sizer/sizer.dart';

class SvgViewer extends StatelessWidget {
  SvgViewer({
    super.key,
    required this.parser,
  });

  final SvgParser parser;

  List<SvgObject> items = [];

  List<SvgObject> getElements() {
    items.clear();
    final rects = parser.getRects();
    final text = parser.getText();
    List<SvgObject> objs = [];
    for (var i = 0; i < rects.length; i++) {
      objs.add(SvgObject(rects[i], text[i]));
    }

    return objs;
  }

  double mapRange(List<double> a, List<double> b, double s) => b[0] + ((s - a[0]) * (b[1] - b[0])) / (a[1] - a[0]);

  @override
  Widget build(BuildContext context) {
    items = getElements();
    final picture = parser.getImage();

    return Sizer(
      builder: (context, orientation, deviceType) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Image.memory(
                    picture.image,
                    fit: BoxFit.fill,
                  ),
                ),
                ...items.map(
                  (e) {
                    final ax = <double>[0, picture.width];
                    final ay = <double>[0, picture.height];
                    final b = <double>[-1, 1];
                    final x = double.parse(mapRange(ax, b, e.rect.x).toStringAsFixed(2));
                    final y = double.parse(mapRange(ay, b, e.rect.y).toStringAsFixed(2));
                    return Align(
                      alignment: Alignment(x, y),
                      child: Container(
                        padding: EdgeInsets.all(1.h),
                        color: Colors.black,
                        child: Text(
                          e.text.child,
                          style: TextStyle(color: Colors.white, fontSize: 5.sp),
                        ),
                      ),
                    );
                  },
                ).toList()
              ],
            );
          },
        );
      },
    );
  }
}
