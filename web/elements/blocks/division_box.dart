library division_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
//import '../../controller/controller.dart';
import '../../main_menu/boxes/calculation/calculation_box.dart';
//import '../block_editor.dart';
import '../../main_menu/boxes/box_factory.dart';

@CustomTag('division-box')
class DivisionBox extends CalculationBox {

  static DivisionBox createBox(program.Divide divideBlock) {
    return (new html.Element.tag('division-box') as DivisionBox)
      ..model = divideBlock
      ..attachLeft(BoxFactory.parseBlock(divideBlock.a))
      ..attachRight(BoxFactory.parseBlock(divideBlock.b));
  }

  program.Divide _model;

  set model(program.Divide m) {
    _model = m;
  }

  get model => _model;

  DivisionBox.created() : super.created();


}