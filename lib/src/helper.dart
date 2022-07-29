import 'package:xml/xml.dart';

String getValue(List<XmlAttribute> attributes, String name) {
  return attributes.firstWhere((element) => element.name.toString() == name).value;
}
