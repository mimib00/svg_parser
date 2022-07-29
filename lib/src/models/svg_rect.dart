import 'package:svg_parser/src/helper.dart';
import 'package:xml/xml.dart';

class SvgRect {
  final double width;
  final double height;
  final double x;
  final double y;

  SvgRect(
    this.width,
    this.height,
    this.x,
    this.y,
  );

  factory SvgRect.fromXml(List<XmlAttribute> attributes) {
    return SvgRect(
      double.parse(getValue(attributes, 'width')),
      double.parse(getValue(attributes, 'height')),
      double.parse(getValue(attributes, 'x')),
      double.parse(getValue(attributes, 'y')),
    );
  }
}
