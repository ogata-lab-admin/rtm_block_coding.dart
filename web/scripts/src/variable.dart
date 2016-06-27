library application.variable;

/// 変数に関する基本クラス

import 'dart:core';
import 'package:xml/xml.dart' as xml;
import 'dart:collection';
import 'statement.dart';

import 'datatype.dart';
import 'block.dart';
import 'block_loader.dart';


/// 変数を定義するブロック
/// 変数名のみを格納する
/// もしC++にまで拡張するなら変数のタイプも持っておくべきだ
class ReferVariable extends Block {
  DataType _dataType;

  get dataType => _dataType;
  set dataType(DataType dt) {
    if (DataType.isPrimitiveType(dt)) {
      _dataType = dt;
    } else {
      print('Error. DeclareValue can not set not-primitive data type: ' +
          dt.typename);
    }
  }


  ReferVariable(String name, this._dataType) : super(name) {}

  toPython(int indentLevel) {
    return name;
  }

  void buildXML(xml.XmlBuilder builder) {
    element(builder, attributes: {'name': name,}, nest: () {});
    element(builder, attributes: {'dataType': _dataType.typename,}, nest: () {});
  }

  ReferVariable.XML(xml.XmlElement node) : super('') {
    name = (node.getAttribute('name'));
    _dataType = new DataType.fromTypeName(node.getAttribute('dataType'));
  }
}


/// 変数の宣言をするブロック
/// 基本的にはonInitializeに追加することを前提としてる
class  DeclareVariable extends Block {
  DataType _dataType;


  get dataType => _dataType;

  set dataType(DataType dt) {
    if (DataType.isPrimitiveType(dt)) {
      _dataType = dt;
    } else {
      print('Error. DeclareValue can not set not-primitive data type: ' +
          dt.typename);
    }
  }

  DeclareVariable(String name, this._dataType) : super(name) {}


  @override
  String toDeclarePython(int indentLevel) {
    String sb = "";
    sb = "self._${name} = " + dataType.constructorString() + '\n';
    return sb;
  }

  @override
  String toBindPython(int indentLevel) {
    return '';
  }

  @override
  String toPython(int indentLevel) {
    return '';
  }

  void buildXML(xml.XmlBuilder builder) {
    element(builder, attributes: {'name' : name}, nest: () {});
    element(builder, attributes: {'dataType': dataType.typename,}, nest: () {});
  }


  DeclareVariable.XML(xml.XmlElement node)  : super('') {
    name = node.getAttribute('name');
    _dataType = new DataType.fromTypeName(node.getAttribute('dataType'));
  }
}