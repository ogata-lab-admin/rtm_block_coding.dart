library if_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../main_menu/boxes/box_factory.dart';
import 'conditions_box.dart';

@CustomTag('if-box')
class IfBox extends ConditionsBox {

  program.If _model;

  static IfBox createBox(program.If m) {
    return new html.Element.tag('if-box') as IfBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition));

/*    for (program.Statement s in m.statements) {
      BlockEditor.parseStatement(IfBox, s);
    }*/
  }

  set model(program.If m) {
    _model = m;
  }

  get model => _model;

  get consequent => $['consequent-content'];

  IfBox.created() : super.created();

}

