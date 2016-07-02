library bool_literal_box;

@HtmlImport('bool_literal_box.html')
import 'dart:html' as html;
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/iron_selector.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../../scripts/application.dart' as program;
import '../box_base.dart';

@PolymerRegister('bool-literal-box')
class BoolLiteralBox extends BoxBase {

  static BoolLiteralBox createBox(program.BoolLiteral m) {
    return new html.Element.tag('bool-literal-box') as BoolLiteralBox
      ..model = m;
  }

  BoolLiteralBox.created() : super.created();

  void attached() {
    selectBool((model as program.BoolLiteral).value);
    $$('#dropdown').addEventListener('iron-select', (var e) {
      (model as program.BoolLiteral).value = e.detail['item'].innerHtml == 'True';
    });
  }

  void selectBool(bool flag) {
    if (flag) {
      ($$('#dropdown') as IronSelector).select('0');
    } else {
      ($$('#dropdown') as IronSelector).select('1');
    }
  }
}
