library port_box;

//import 'dart:html' as html;
//import 'package:rtm_block_coding/application.dart' as program;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
//import 'box_base.dart';
//import 'package:paper_elements/paper_item.dart';
//import 'package:paper_elements/paper_dropdown_menu.dart';

@CustomTag('port-box')
class PortBox extends PolymerElement {

  PolymerElement parentElement;

  PortBox.created() : super.created();

  void onClicked(var e) {
    globalController.setSelectedElem(e, this);
    e.stopPropagation();
  }

  void select() {
    $['container'].style.border = 'ridge';
    $['container'].style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $['container'].style.border = '1px solid #B6B6B6';
  }

  bool is_container() {
    return false;
  }

}