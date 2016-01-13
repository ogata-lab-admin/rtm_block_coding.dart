library application.basic_operator;


import 'package:xml/xml.dart' as xml;
import 'dart:core';
import 'block.dart';
import 'block_loader.dart';

/// 変数を定義するブロック
/// 変数名のみを格納する
/// もしC++にまで拡張するなら変数のタイプも持っておくべきだ
class Variable extends Block {

  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
  }

  void buildXML(xml.XmlBuilder builder) {
    element(builder,
        attributes: {
          'name' : _name,
        },
        nest : () {

        });
  }

  Variable.XML(xml.XmlElement node) {
    _name = (node.getAttribute('name'));
  }
}

/// 変数にデータを代入する処理
/// ＝演算子
/// 代入先は基本的に変数だからleftはVariable型
/// 右辺はブロックが入る．Addなどの演算結果も受けることができる
class SetVariable extends Block {
  Variable _left;
  Block _right;

  get left => _left;
  get right => _right;

  set right(var r) => _right = r;

  SetVariable(this._left, this._right) {

  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} = ${_right.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {},
        nest : () {
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

  SetVariable.XML(xml.XmlElement node) {
    namedChildChildren(node, 'Left', (xml.XmlElement e) {
      _left = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'Right', (xml.XmlElement e) {
      _right = BlockLoader.parseBlock(e);
    });

  }
}

/// 中置型の二項演算子の親クラス
/// operatorStringに*や+, /, %などの演算子の文字が入る
/// このクラスを継承してAddなどを作ること
class BasicOperator extends Block {
  Block _a;
  Block _b;

  get a => _a;
  get b => _b;

  String _operatorString = 'foo';

  BasicOperator(this._a, this._b, this._operatorString) {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} ${_operatorString} ${b.toPython(0)}";
  }

  void buildXML(xml.XmlBuilder builder) {
    super.element(builder,
        attributes: {
        },
        nest : () {
          builder.element('a',
              nest : () {
                a.buildXML(builder);
              });
          builder.element('b',
              nest : () {
                b.buildXML(builder);
              });
        });
  }


  void loadXML(xml.XmlElement node) {
    namedChildChildren(node, 'a', (xml.XmlElement e) {
      _a = BlockLoader.parseBlock(e);
    });
    namedChildChildren(node, 'b', (xml.XmlElement e) {
      _b = BlockLoader.parseBlock(e);
    });
  }
}

/// 加算
class Add extends BasicOperator {

  Add(Block a_, Block b_) : super(a_, b_, '+') {}

  Add.XML(xml.XmlElement node) : super(null, null, '+') {
    loadXML(node);
  }
}


/// 減産
class Subtract extends BasicOperator {

  Subtract(Block a_, Block b_) : super(a_, b_, '-') {}

  Subtract.XML(xml.XmlElement node) : super(null, null, '-') {
    loadXML(node);
  }

}

/// 乗算
class Multiply extends BasicOperator {
  Subtract(Block a_, Block b_) : super(a_, b_, '*') {}

  Subtract.XML(xml.XmlElement node) : super(null, null, '*') {
    loadXML(node);
  }
}

/// 除算
class Div extends BasicOperator {
  Div(Block a_, Block b_) : super(a_, b_, '/') {}

  Div.XML(xml.XmlElement node) : super(null, null, '/') {
    loadXML(node);
  }
}