library read_literal_box;

import 'dart:html' as html;
import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'literal_box.dart';

@CustomTag('real-literal-box')
class RealLiteralBox extends LiteralBox {

  program.RealLiteral _model;

  static RealLiteralBox createBox(program.RealLiteral m) {
    return new html.Element.tag('real-literal-box') as RealLiteralBox
      ..model = m;
  }

  set model(program.RealLiteral m) {
    _model = m;
    dvalue = m.value;
    dvaluestr = dvalue.toString();
  }

  get model => _model;

  double dvalue = 1.0;
  @observable String dvaluestr;
  RealLiteralBox.created() : super.created();

  void attached() {
    $['real-literal-input'].onChange.listen((var e) {
      _model.value = dvalue;
    });
  }

}
