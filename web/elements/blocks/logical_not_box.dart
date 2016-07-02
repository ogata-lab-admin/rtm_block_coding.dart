library logical_not_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
//import '../block_editor.dart';
import '../../main_menu/boxes/box_factory.dart';
//import '../../controller/controller.dart';
import '../../main_menu/boxes/comparison/comparison_box.dart';

@CustomTag('logical-not-box')
class LogicalNotBox extends ConditionsBox {

  program.Not _model;

  String leftLabel;
  String rightLabel;

  static LogicalNotBox createBox(program.Not m) {
    return new html.Element.tag('logical-not-box') as LogicalNotBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition));
  }

  set model(program.Not m) {
    _model = m;
    condition = m.condition;
  }

  get model => _model;

  @published program.Condition condition = null;

  LogicalNotBox.created() : super.created();

}

