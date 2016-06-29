library application.flow_control;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'base.dart';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';
import 'literal.dart';
import 'block_loader.dart';

class If extends Block {
  Condition condition;

  If(this.condition) : super('')  {
    //statements = s;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if ${condition.toPython(0)}:\n";
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    sb += Statement.indent * (indentLevel+1) + 'pass' + '\n';
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          builder.element('Condition',
            nest : () {
              condition.buildXML(builder);
            });
          statements.buildXML(builder);
        });
  }


  If.XML(xml.XmlElement node) : super('')  {
    namedChildChildren(node, 'Condition', (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }

  @override
  bool is_container() {
    return true;
  }

  If.fromAppDefault(Application app) : super('') {
    condition = new TrueLiteral();
  }

}

class Else extends Block {

  Else() : super('')  {
    //statements = s;
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }

  String toPython(int indentLevel) {
    String sb = "";
    if (statements != null) {
      sb += Statement.indent * indentLevel + "else : \n";
      for (Statement s in statements) {
        sb += s.toPython(indentLevel + 1) + '\n';
      }
      sb += Statement.indent * (indentLevel+1) + 'pass' + '\n';
    }
    return sb;
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          statements.buildXML(builder);
        });
  }

  Else.XML(xml.XmlElement node) : super('')  {
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }

  @override
  bool is_container() {
    return true;
  }
}

class While extends Block {
  Condition condition;

  While(this.condition) : super('')  {
    //statements = s;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "while ${condition.toPython(0)}:\n";
    for (Statement s in statements) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    sb += Statement.indent * (indentLevel+1) + 'pass' + '\n';

    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          builder.element('Condition',
              nest : () {
                condition.buildXML(builder);
              });

          builder.element('Loop',
              nest : () {
                statements.buildXML(builder);
              });
        });
  }

  While.XML(xml.XmlElement node) : super('')  {
    namedChildChildren(node, 'Condition', (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Loop', (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }

  @override
  bool is_container() {
    return true;
  }
}

class Break extends Block {

  Break() : super('')  {}

  String toPython(int indentLevel) {
    return 'break';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  Break.XML(xml.XmlElement node) : super('')  {

  }
}

class Continue extends Block {

  Continue() : super('')  {}

  String toPython(int indentLevel) {
    return 'continue';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {

        });
  }

  Continue.XML(xml.XmlElement node) : super('')  {

  }
}

class Pass extends Block {

  Pass() : super('')  {}

  String toPython(int indentLevel) {
    return 'pass';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
        });
  }

  Pass.XML(xml.XmlElement node)  : super('') {

  }
}