import 'package:svg_parser/src/models/svg_rect.dart';
import 'package:svg_parser/src/models/svg_text.dart';

class SvgObject {
  final SvgRect rect;
  final SvgText text;

  SvgObject(this.rect, this.text);
}
