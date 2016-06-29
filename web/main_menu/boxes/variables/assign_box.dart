library assign_box;

@HtmlImport('assign_box.html')
import 'dart:html' as html;
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../../scripts/application.dart' as program;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_item.dart';
import '../box_factory.dart';
import '../../../controller/controller.dart';
import '../box_base.dart';

@PolymerRegister('assign-box')
class AssignBox extends BoxBase {


  static AssignBox createBox(program.Assign m) {
    return new html.Element.tag('assign-box') as AssignBox
      ..model = m;
  }

  @property String varname = "defaultName";

  AssignBox.created() : super.created();

  void attached() {
    attachLeftTarget(BoxFactory.parseBlock((model as program.Assign).left));
    attachRightTarget(BoxFactory.parseBlock((model as program.Assign).right));
  }

  void attachRightTarget(var element) {
    $$('#right-content').children.clear();
    $$('#right-content').children.add(element);
    element.parentElement = this;
  }

  void attachLeftTarget(var element) {
    $$('#left-content').children.clear();
    $$('#left-content').children.add(element);
    element.parentElement = this;
  }

}
