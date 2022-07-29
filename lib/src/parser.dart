import 'dart:developer';

import 'package:svg_parser/src/models/svg_image.dart';
import 'package:svg_parser/src/models/svg_text.dart';
import 'package:xml/xml.dart';

import 'models/svg_rect.dart';

class SvgParser {
  /// Takes [source] and parse it.
  SvgParser(this.source) {
    try {
      _document = XmlDocument.parse(source);
    } on XmlException catch (e) {
      log(e.message);
    }
  }

  /// The content of the svg file as a string.
  final String source;

  /// Holds the parsed [source].
  XmlDocument? _document;

  SvgImage getImage() {
    final query = _query('image');
    final image = query.first;
    return SvgImage.fromXml(image.attributes);
  }

  /// Get all the rects in the svg
  List<SvgRect> getRects() {
    final rects = <SvgRect>[];
    final query = _query('rect');
    final attribs = <XmlAttribute>[];
    for (var rect in query) {
      if (rect.attributes.where((p0) => p0.value == "transparent").isNotEmpty) {
        continue;
      }
      for (var attribute in rect.attributes) {
        attribs.add(attribute);
      }
      rects.add(SvgRect.fromXml(attribs));
      attribs.clear();
    }
    return rects;
  }

  /// Get all the text in the svg
  List<SvgText> getText() {
    final texts = <SvgText>[];
    final query = _query('text');
    final attribs = <XmlAttribute>[];
    for (var text in query) {
      for (var attribute in text.attributes) {
        attribs.add(attribute);
      }
      texts.add(SvgText.fromXml(attribs, text.innerText));
      attribs.clear();
    }
    return texts;
  }

  /// Takes an svg [tag] and find all the elements with that tag in [source].
  List<XmlElement> _query(String tag) => _document != null ? _document!.findAllElements(tag).toList() : [];
}
