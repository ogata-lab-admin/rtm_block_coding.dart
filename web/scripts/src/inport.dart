part of application;
/*


library application.inport;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'base.dart';
import 'statement.dart';
import 'datatype.dart';
import 'block_loader.dart';
import 'port.dart';
import 'condition.dart';
*/
class AddInPort extends AddPort {

  AddInPort(String inName_, DataType inDataType_) : super(inName_, inDataType_) {
  }

  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._d_${name} = " + dataType.constructorString() + '\n';
    sb += Statement.indent * indentLevel + 'self._${name}In = OpenRTM_aist.InPort("${name}", self._d_${name})' + '\n';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    String sb = "";
    sb = 'self.addInPort("${name}", self._${name}In)' + '\n';
    return sb;
  }

  String toPython(int indentLevel) {
    return '';
  }

  AddInPort.XML(xml.XmlElement node) : super.XML(node){
  }

  AddInPort.fromAppDefault(Model app) : super(app.onInitializeApp.getDefaultInPortName(), new DataType.TimedLong()){
  }
}


class InPortBuffer extends Block {
  DataType dataType;
  String accessSequence;

  InPortBuffer(String name, this.dataType, this.accessSequence) : super(name) {
  }

  String toPython(int indentLevel) {
    return 'self._d_${name}${accessSequence}';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder, attributes: {
      'name' : name,
      'accessSequence' : accessSequence,
    }, nest: () {
      dataType.buildXML(builder);
    });
  }

  InPortBuffer.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }

  InPortBuffer.fromAppDefault(Model app) : super('') {
    var portList = app.onInitializeApp.find(AddInPort);
    name = portList[0].name;
    dataType = portList[0].dataType;
    accessSequence = '';
  }
}

/*
class InPortBuffer extends Block {
  DataType dataType;
  String accessSequence;

  InPortBuffer(String name, this.dataType, this.accessSequence) : super(name) {
  }

  String toPython(int indentLevel) {
    if (accessSequence.trim().length == 0) {
      return 'self._d_${name}';
    }
    return 'self._d_${name}.${accessSequence}';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name,
          'accessSequence' : accessSequence,
        },
        nest: () {
          dataType.buildXML(builder);
        });
  }

  InPortBuffer.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    accessSequence = node.getAttribute('accessSequence');
    child(node, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }
}

*/


/// Is New Method
class IsNewInPort extends Condition {
  DataType dataType;

  IsNewInPort(String name, this.dataType) : super()  {
    this.name = name;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "self._${name}In.isNew()";
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

  IsNewInPort.XML(xml.XmlElement node) : super() {
    name = node.getAttribute('name');
    typedChild(node, DataType, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }

  IsNewInPort.fromAppDefault(Model app) {
    var inPortList = app.onInitializeApp.find(AddInPort);
    name = inPortList[0].name;
    dataType = inPortList[0].dataType;
  }
}

///
class ReadInPort extends Block {
  DataType dataType;

  ReadInPort(String name, this.dataType) : super(name)  {
  }


  String toPython(int indentLevel) {
    String sb = "";
    sb += 'self._d_${name} = self._${name}In.read()';
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

  ReadInPort.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    typedChild(node, DataType, (xml.XmlElement e) {
      dataType = new DataType.XML(e);
    });
  }

  ReadInPort.fromAppDefault(Model app) : super(app.onInitializeApp.find(AddInPort)[0].name) {
    dataType = app.onInitializeApp.find(AddInPort)[0].dataType;
  }

}

/*
class ReadInPort extends Block {
  DataType dataType;

  //StatementList statements = new StatementList([]);

  ReadInPort(String name, this.dataType) : super(name)  {
  }


  @override
  bool is_container() {
    return true;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if self._${name}In.isNew():\n";
    sb += Statement.indent * (indentLevel+1) + 'self._d_${name} = self._${name}In.read()\n';
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    sb += Statement.indent * (indentLevel + 1) + 'pass' + '\n';
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for(var s in statements) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
          'name' : name
        },
        nest: () {
          dataType.buildXML(builder);
          statements.buildXML(builder);
        });
  }

  ReadInPort.XML(xml.XmlElement node) : super('') {
    name = node.getAttribute('name');
    typedChild(node, DataType, (xml.XmlElement e) {
        dataType = new DataType.XML(e);
    });
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }
}
*/