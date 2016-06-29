library smaller_than_or_equals_box;
import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../main_menu/block_editor.dart';
import '../../main_menu/boxes/box_factory.dart';
import '../../controller/controller.dart';
import 'conditions_box.dart';

@CustomTag('smaller-than-or-equals-box')
class SmallerThanOrEqualsBox extends ConditionsBox {

  program.SmallerThanOrEquals _model;

  String leftLabel;
  String rightLabel;

  static SmallerThanOrEqualsBox createBox(program.SmallerThanOrEquals m) {
    return new html.Element.tag('smaller-than-or-equals-box') as SmallerThanOrEqualsBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  set model(program.SmallerThanOrEquals m) {
    _model = m;
    leftLabel = m.left.toPython(0);
    rightLabel = m.right.toPython(0);
  }

  get model => _model;

  SmallerThanOrEqualsBox.created() : super.created();

}

