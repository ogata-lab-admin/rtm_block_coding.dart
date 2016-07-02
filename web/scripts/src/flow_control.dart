

part of application;
/*

library application.flow_control;

import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'base.dart';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';
import 'literal.dart';
import 'block_loader.dart';
 */


abstract class ContainerBlock extends Block {

  ContainerBlock(String name) : super(name) {}

  @override
  bool is_container() {
    return true;
  }

  @override
  void iterateBlock(var func) {
    for (var s in statements) {
      s.iterateBlock(func);
    }
  }
}


class ConditionalFlowControl extends ContainerBlock {
  Condition _condition;

  get condition => _condition;

  set condition(Condition cond) {
    _condition = cond;
    condition.parent = this;
  }

  ConditionalFlowControl(this._condition) : super('') {
    this._condition.parent = this;
  }

  @override
  String toPython(int indentLevel) {
    return '';
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder, attributes: {},
        nest: () {
          builder.element('Condition',
              nest : () {
                condition.buildXML(builder);
              });
          statements.buildXML(builder);
        });
  }

  ConditionalFlowControl.XML(xml.XmlElement node) : super('')  {
    namedChildChildren(node, 'Condition', (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
    typedChild(node, StatementList, (xml.XmlElement e) {
      statements.loadFromXML(e);
    });
  }

  ConditionalFlowControl.fromAppDefault(Application app) : super('') {
    condition = new BoolLiteral(true);
  }
}


class If extends ConditionalFlowControl {

  If(Condition cond) : super(cond) {
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


  If.XML(xml.XmlElement node) : super.XML(node) {
  }

  If.fromAppDefault(Application app) : super.fromAppDefault(app) {

  }

}

class Else extends ContainerBlock {

  Else() : super('')  {
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

  Else.fromAppDefault(Application app) : super('') {

  }
}

class While extends ConditionalFlowControl {


  While(Condition cond) : super(cond)  {
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

  While.XML(xml.XmlElement node) : super.XML(node) {
  }

  While.fromAppDefault(Application app) : super.fromAppDefault(app) {}
}

class Break extends Block {

  Break() : super('')  {}

  String toPython(int indentLevel) {
    return 'break';
  }

  Break.XML(xml.XmlElement node) : super('')  {
  }
}

class Continue extends Block {

  Continue() : super('')  {}

  String toPython(int indentLevel) {
    return 'continue';
  }


  Continue.XML(xml.XmlElement node) : super('')  {
  }
}

class Pass extends Block {

  Pass() : super('')  {}

  String toPython(int indentLevel) {
    return 'pass';
  }

  Pass.XML(xml.XmlElement node)  : super('') {
  }
}