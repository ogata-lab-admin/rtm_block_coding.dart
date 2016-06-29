library variable_box;

import 'dart:html' as html;
import 'dart:async' as async;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html' as html;
// import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';

@PolymerRegister('variable-box')
class VariableBox extends PolymerElement {

  PolymerElement parentElement;

  VariableBox.created() : super.created();

  void onClicked(var e) {
    globalController.setSelectedBox(e, this);
    e.stopPropagation();
  }

  void select() {
    $['container'].style.border = 'ridge';
    $['container'].style.borderColor = '#FF9F1C';
    ($['container'] as html.HtmlElement).style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['container'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }
}