library integer_literal_box;

@HtmlImport('integer_listeral_box.html')
import 'dart:html' as html;
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../scripts/application.dart' as program;
import 'box_base.dart';

@PolymerRegister('integer-literal-box')
class IntegerLiteralBox extends BoxBase {

  static IntegerLiteralBox createBox(program.IntegerLiteral m) {
    return new html.Element.tag('integer-literal-box') as IntegerLiteralBox
      ..model = m
      ..intvalue = m.value
      ..intvarstr = m.value.toString();
  }

  int intvalue = 1;
  @property String intvarstr;

  IntegerLiteralBox.created() : super.created();

  @reflectable
  void onInputValue(var e, var d) {
    intvalue = int.parse(intvarstr);
    (model as program.IntegerLiteral).value = intvalue;
  }

  void attached() {

  }

}
