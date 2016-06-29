library box_base;


// @HtmlImport('box_base.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import '../../controller/controller.dart';
import '../../scripts/application.dart';

// @PolymerRegister('box-base')
class BoxBase extends PolymerElement {
  PolymerElement parentElement;

  Block _model;
//とりあえずvar型にしてあるけどあまりよくない

  set model(Block m) {
    _model = m;
  }

  Block get model => _model;

  BoxBase.created() : super.created();

  @reflectable
  void onClicked(var e, var d) {
    print('AddPortBox.onClicked($e, $d)');
    globalController.setSelectedBox(this);
    e.stopPropagation();
  }

  void select() {
    $$('#container').style.border = 'ridge';
    $$('#container').style.borderColor = '#FF9F1C';
  }

  void deselect() {
    $$('#container').style.border = '1px solid #B6B6B6';
  }
}