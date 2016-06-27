library smaller_than_box;


import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../main_menu/block_parser.dart';
import 'conditions_box.dart';

@CustomTag('smaller-than-box')
class SmallerThanBox extends ConditionsBox {

  program.SmallerThan _model;

  String leftLabel;
  String rightLabel;

  static SmallerThanBox createBox(program.SmallerThan m) {
    return new html.Element.tag('smaller-than-box') as SmallerThanBox
      ..model = m
      ..attachLeft(BlockParser.parseBlock(m.left))
      ..attachRight(BlockParser.parseBlock(m.right));
  }

  set model(program.SmallerThan m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  SmallerThanBox.created() : super.created();

}

