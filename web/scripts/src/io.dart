

library application.io;


import 'package:xml/xml.dart' as xml;
import 'block.dart';
import 'block_loader.dart';

class Print extends Block {

  Block _block;
  Print(this._block)  : super('') {}

  String toPython(int indentLevel) {
    return "print ${_block.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          _block.buildXML(builder);
        });
  }

  Print.XML(xml.XmlElement node) : super('') {
    child(node, (xml.XmlElement e) {
      _block = BlockLoader.parseBlock(e);
    });
  }
}