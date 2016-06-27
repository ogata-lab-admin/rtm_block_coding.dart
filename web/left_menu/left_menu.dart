library left_menu;


@HtmlImport('left_menu.html')
import 'dart:html' as html;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'collapse_menu.dart';
import 'add_element_button.dart';

//import 'package:http/browser_client.dart' as browser_client;
//import 'package:core_elements/core_menu.dart';
//import 'package:core_elements/core_drawer_panel.dart';
//import 'package:core_elements/core_collapse.dart';
//import 'package:paper_elements/paper_button.dart' as paper_button;
//import 'collapse_menu.dart';
//import 'add_element_button.dart';
//import 'dart:async';
//import '../controller/controller.dart';
//import 'package:xml/xml.dart' as xml;

//import 'package:wasanbon_xmlrpc/wasanbon_xmlrpc.dart' as wasanbon;

@PolymerRegister('left-menu')
class LeftMenu extends PolymerElement {

  LeftMenu.created() :  super.created();

  @override
  void attached() {
  }
}