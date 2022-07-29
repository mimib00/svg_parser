import 'dart:convert';
import 'dart:typed_data';

import 'package:svg_parser/src/helper.dart';
import 'package:xml/xml.dart';

class SvgImage {
  final String id;
  final double width;
  final double height;
  final double x;
  final double y;
  final Uint8List image;

  SvgImage(
    this.id,
    this.width,
    this.height,
    this.x,
    this.y,
    this.image,
  );

  factory SvgImage.fromXml(List<XmlAttribute> attributes) {
    final bin = getValue(attributes, 'xlink:href').replaceRange(0, 22, '');
    Uint8List bytes = base64.decode(bin);

    // final Image = Unit8List;
    return SvgImage(
      getValue(attributes, 'id'),
      double.parse(getValue(attributes, 'width')),
      double.parse(getValue(attributes, 'height')),
      double.parse(getValue(attributes, 'x')),
      double.parse(getValue(attributes, 'y')),
      bytes,
    );
  }
}
