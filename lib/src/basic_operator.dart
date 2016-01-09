library application.basic_operator;


import 'dart:core';
import 'block.dart';


class Variable extends Block {

  String _name;

  get name => _name;

  set name(String n) => _name = n;

  Variable(this._name) {}

  toPython(int indentLevel) {
    return _name;
  }
}

class SetValue extends Block {
  Variable _left;
  Block _right;

  get left => _left;
  get right => _right;

  set right(var r) => _right = r;

  SetValue(this._left, this._right) {

  }

  String toPython(int indentLevel) {
    return "${_left.toPython(0)} = ${_right.toPython(0)}";
  }
}

class Add extends Block {

  int _a;
  int _b;

  get value_a => _a;
  set value_a(int i) => _a = i;

  get value_b => _b;
  set value_b(int j) => _b = j;

  Add(this._a, this._b) {}
//  Add(this._a, this._b) : super() {}

  String toPython(int indentLevel) {
      return _a.toString();
//    return _a.toString()  + "${+}" +  _b.toString();
  }
}

/*
class Add extends Block {
  Block a;
  Block b;

  Add(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} + ${b.toPython(0)}";
  }

}*/

class Subtract extends Block {
  Block a;
  Block b;

  Subtract(this.a, this.b) : super() {}

  String toPython(int indentLevel) {
    return "${a.toPython(0)} - ${b.toPython(0)}";
  }

}