part of application;
/*


library application.outport;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'base.dart';
import 'block.dart';
import 'statement.dart';
import 'datatype.dart';
import 'block_loader.dart';
import 'port.dart';
*/
class AddOutPort extends AddPort {

  AddOutPort(String outName_, DataType outDataType_) : super(outName_, outDataType_) {
  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel + 'self._${name}Out = OpenRTM_aist.OutPort("${name}", self._d_${name})';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addOutPort("${name}", self._${name}Out)';
    return sb;
  }

  String toPython(int indentLevel) {
    return '';
  }

  AddOutPort.XML(xml.XmlElement node) : super.XML(node) {
  }

  AddOutPort.fromAppDefault(Model app) : super(app.onInitializeApp.getDefaultOutPortName(), new DataType.TimedLong()){
  }
}


class OutPortBuffer extends Block {
  //Block right;
  DataType dataType;
  String accessSequence;

  OutPortBuffer(String name, this.dataType, this.accessSequence) : super(name) {
  }

  String toPython(int indentLevel) {
    return "self._d_${name}${accessSequence}";// = ${right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name,
          'accessSequence' :accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
          /*
          builder.element('Right',
            nest: () {
              right.buildXML(builder);
            }
          );
          */
        });
  }

  OutPortBuffer.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
    /*
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      right = BlockLoader.parseBlock(e);
    });
    */
  }

  OutPortBuffer.fromAppDefault(Model app) : super('') {
    var portList = app.onInitializeApp.find(AddOutPort);
    name = portList[0].name;
    dataType = portList[0].dataType;
    accessSequence = '';
  }
}

class WriteOutPort extends Block {
  DataType dataType;

  WriteOutPort(String name, this.dataType) : super(name) {
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = 'self._${name}Out.write()';
    return sb;
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  WriteOutPort.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }

  WriteOutPort.fromAppDefault(Model app) : super('') {
    var portList = app.onInitializeApp.find(AddOutPort);
    name = portList[0].name;
    dataType = portList[0].dataType;
  }
}