library if_box;

@HtmlImport('if_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../../scripts/application.dart' as program;
import '../box_factory.dart';
import '../box_base.dart';

@PolymerRegister('if-box')
class IfBox extends BoxBase {

  static IfBox createBox(program.If m) {
    return new html.Element.tag('if-box') as IfBox
      ..model = m
      ..attachCondition(BoxFactory.parseBlock(m.condition))
      ..attachStatements(m);
  }

  get consequent => $['consequent-content'];

  IfBox.created() : super.created();

  void attachCondition(var e) {
    $$('#condition-content').children.clear();
    $$('#condition-content').children.add(e);
    e.parentElement = this;
  }

  void attachStatements(program.If m) {
    for(program.Statement s in m.statements) {
      var e = BoxFactory.parseBlock(s.block);
      $$('#consequent-content').children.add(e);
      e.parentElement = this;
    }
  }
}

