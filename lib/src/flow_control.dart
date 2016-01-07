library application.flow_control;



import 'dart:core';
import 'block.dart';
import 'condition.dart';
import 'statement.dart';

class If extends Block {
  Condition condition;
  StatementList yes = new StatementList([]);
  StatementList no = new StatementList([]);

  If(this.condition, this.yes, {StatementList no: null}) {
    this.no = no;
  }

  String toPython(int indentLevel) {
    String sb = "";
    sb = "if ${condition.toPython(0)}:\n";
    for (Statement s in yes) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    if (no != null) {
      sb += Statement.indent * indentLevel + "else : \n";
      for (Statement s in no) {
        sb += s.toPython(indentLevel + 1) + '\n';
      }
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in yes) {
      s.iterateBlock(func);
    }
    for (var s in no) {
      s.iterateBlock(func);
    }
  }
}

class While extends Block {
  Condition condition;

  StatementList loop = new StatementList([]);

  While(this.condition, this.loop) {}


  String toPython(int indentLevel) {
    String sb = "";
    sb = "while ${condition.toPython(0)}:\n";
    for (Statement s in loop) {
      sb += s.toPython(indentLevel + 1) + '\n';
    }
    return sb;
  }

  @override
  void iterateBlock(var func) {
    for (var s in loop) {
      s.iterateBlock(func);
    }
  }
}

class Break extends Block {

  Break() {}

  String toPython(int indentLevel) {
    return 'break';
  }
}