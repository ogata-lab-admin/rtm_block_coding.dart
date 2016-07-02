part of application;
/*
library application.condition;
import 'block.dart';


import 'package:xml/xml.dart' as xml;
import 'block_loader.dart';
*/

/// 条件部のためのクラス
/// 条件部はbool型になるため，
/// 単なるBlockを受けるようにしていると
/// 構文チェックが難しい
/// そこでBool型はConditionクラスを継承することにする．
abstract class Condition extends Block with VariableBlock {
  Condition() : super('')  {}
}


/// 中置型の比較演算子の抽象クラス
class BasicComparison extends Condition {
  String _operatorString = 'foo';
  Block _right;
  Block _left;

  get right => _right;

  get left => _left;

  BasicComparison(this._left, this._right, this._operatorString) {}

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} ${_operatorString} ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          builder.element('Left',
              nest: () {
                _left.buildXML(builder);
              });
          builder.element('Right',
              nest: () {
                _right.buildXML(builder);
              });
        });
  }

  void loadXML(xml.XmlElement node) {
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      _right = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Left', (xml.XmlElement e) {
      _left = BlockLoader.parseBlock(e);
    });
  }
}

class Equals extends BasicComparison {

  Equals(Block left, Block right) : super(left, right, '==') {
  }

  Equals.XML(xml.XmlElement node) : super(null, null, '==') {
    super.loadXML(node);
  }

  Equals.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '==') {}
}


class NotEquals extends BasicComparison {

  NotEquals(Block left, Block right) : super(left, right, '!='){
  }

  NotEquals.XML(xml.XmlElement node) : super(null, null, '!=') {
    super.loadXML(node);
  }

  NotEquals.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '!=') {}
}



class SmallerThan extends BasicComparison {
  SmallerThan(Block left, Block right) : super(left, right, '<'){
  }

  SmallerThan.XML(xml.XmlElement node) : super(null, null, '<') {
    super.loadXML(node);
  }

  SmallerThan.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '<') {}

}


class SmallerThanOrEquals extends BasicComparison {
  SmallerThanOrEquals(Block left, Block right) : super(left, right, '<='){
  }

  SmallerThanOrEquals.XML(xml.XmlElement node) : super(null, null, '<=') {
    super.loadXML(node);
  }

  SmallerThanOrEquals.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '<=') {}

}

class LargerThan extends BasicComparison {
  LargerThan(Block left, Block right) : super(left, right, '>'){
  }
  LargerThan.XML(xml.XmlElement node) : super(null, null, '>')  {
    super.loadXML(node);
  }

  LargerThan.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '>') {}

}


class LargerThanOrEquals extends BasicComparison {
  LargerThanOrEquals(Block left, Block right) : super(left, right, '>='){
  }
  LargerThanOrEquals.XML(xml.XmlElement node) : super(null, null, '>=') {
    super.loadXML(node);
  }
  LargerThanOrEquals.fromAppDefault(Model app) : super(new IntegerLiteral(0), new IntegerLiteral(0), '>=') {}

}


class Not extends Condition {

  Condition condition;

  Not(this.condition) {}

  String toPython(int indentLevel) {
    return "not ${condition.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest: () {
          condition.buildXML(builder);
        });
  }

  Not.XML(xml.XmlElement node) {
    child(node, (xml.XmlElement e) {
      condition = BlockLoader.parseBlock(e);
    });
  }

  Not.fromAppDefault(Model app) : super() {
    this.condition = new BoolLiteral(true);
  }

}