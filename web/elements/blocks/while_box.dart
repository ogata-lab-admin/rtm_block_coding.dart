library while_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../main_menu/block_parser.dart';
import 'conditions_box.dart';

@CustomTag('while-box')
class WhileBox extends ConditionsBox {

  program.While _model;

  static WhileBox createBox(program.While m) {
    return new html.Element.tag('while-box') as WhileBox
      ..model = m
      ..attachCondition(BlockParser.parseBlock(m.condition));
  }

  set model(program.While m) {
    _model = m;
  }

  get model => _model;

  get loop => $['loop-content'];

  WhileBox.created() : super.created();

}

