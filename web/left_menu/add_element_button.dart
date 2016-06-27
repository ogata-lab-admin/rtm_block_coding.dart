library add_element_button;

@HtmlImport('add_element_button.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../controller/controller.dart';

import 'package:polymer_elements/paper_button.dart';

@PolymerRegister('add-element-button')
class AddElementButton extends PolymerElement {

  AddElementButton.created() :  super.created();

  @property String label = 'title';
  @property String command = 'command';

  @override
  void attached() {}

  @reflectable
  void onTap(var e, var d) {
    globalController.addElement(this.command);
  }

  void setEnabled(bool flag) {
    PaperButton btn = $['main-button'];
    btn.disabled = !flag;
  }

}