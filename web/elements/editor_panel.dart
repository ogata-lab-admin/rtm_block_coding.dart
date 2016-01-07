import 'package:polymer/polymer.dart';
import '../controller/controller.dart';
import 'block_editor.dart';

@CustomTag('editor-panel')
class EditorPanel extends PolymerElement {

  @observable var selected;
  EditorPanel.created() :  super.created();

  var parent;

  void setParent(var parent) {
    this.parent = parent;
  }

  @override
  void attached() {
    selected = 0;
    globalController.editorPanel = this;
  }

  void refresh(var app) {
    BlockEditor editor;
    switch(selected) {
      case 0:
        editor = $['on_initialize_editor'];
        break;
      case 1:
        editor = $['on_activated_editor'];
        break;
      case 2:
        editor = $['on_execute_editor'];
        break;
      case 3:
        editor = $['on_deactivated_editor'];
        break;
    }
    editor.refresh(app);
  }


  void updateClick() {
    BlockEditor editor;
    switch(selected) {
      case 0:
        editor = $['on_initialize_editor'];
        break;
      case 1:
        editor = $['on_activated_editor'];
        break;
      case 2:
        editor = $['on_execute_editor'];
        break;
      case 3:
        editor = $['on_deactivated_editor'];
        break;
    }
    editor.updateClick();
  }

  void onSelectInitialize(var e) {
    parent.setMode('initialize');
  }

  void onSelectActivated(var e) {
    parent.setMode('activate');

  }


  void onSelectDeactivated(var e) {
    parent.setMode('deactivate');

  }


  void onSelectExecute(var e) {
    parent.setMode('execute');

  }


}