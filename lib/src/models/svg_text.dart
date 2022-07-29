import 'package:svg_parser/src/helper.dart';
import 'package:xml/xml.dart';

class SvgText {
  final double x;
  final double y;
  final String child;

  SvgText(
    this.x,
    this.y,
    this.child,
  );

  factory SvgText.fromXml(List<XmlAttribute> attributes, String text) {
    return SvgText(
      double.parse(getValue(attributes, 'x')),
      double.parse(getValue(attributes, 'y')),
      text,
    );
  }
}
