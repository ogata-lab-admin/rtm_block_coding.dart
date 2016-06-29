library subtraction_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'calculation_box.dart';
import '../../main_menu/boxes/box_factory.dart';

@CustomTag('subtraction-box')
class SubtractionBox extends CalculationBox {

  static SubtractionBox createBox(program.Subtract subtractBlock) {
    return (new html.Element.tag('subtraction-box') as SubtractionBox)
        ..model = subtractBlock
        ..attachLeft(BoxFactory.parseBlock(subtractBlock.a))
        ..attachRight(BoxFactory.parseBlock(subtractBlock.b));
  }

  program.Subtract _model;

  set model(program.Subtract m) {
    _model = m;
  }

  get model => _model;

  SubtractionBox.created() : super.created();

}