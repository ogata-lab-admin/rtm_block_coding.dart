library box_base;


// @HtmlImport('box_base.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

// @PolymerRegister('box-base')
class BoxBase extends PolymerElement {
  PolymerElement parentElement;

  var _model;
//とりあえずvar型にしてあるけどあまりよくない

  set model(var m) {
    _model = m;
  }

  get model => _model;

  BoxBase.created() : super.created();
}