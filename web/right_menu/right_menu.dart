library right_menu;


@HtmlImport('right_menu.html')
import 'dart:html' as html;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'python_panel.dart';

@PolymerRegister('right-menu')
class RightMenu extends PolymerElement {

  RightMenu.created() :  super.created();

  @override
  void attached() {
  }
}