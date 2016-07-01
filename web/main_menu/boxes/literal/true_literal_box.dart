library true_literal_box;

@HtmlImport('truelisteral_box.html')
import 'dart:html' as html;
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../../scripts/application.dart' as program;
import '../box_base.dart';

@PolymerRegister('true-literal-box')
class TrueLiteralBox extends BoxBase {

  static TrueLiteralBox createBox(program.TrueLiteral m) {
    return new html.Element.tag('true-literal-box') as TrueLiteralBox
      ..model = m;
  }

  TrueLiteralBox.created() : super.created();


  void attached() {

  }

}
