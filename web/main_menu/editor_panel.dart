library editor_panel;
import 'package:polymer/polymer.dart';

@HtmlImport('editor_panel.html')
import 'dart:html' as html;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer_elements/paper_tabs.dart';

import '../controller/controller.dart';
import 'block_editor.dart';

@PolymerRegister('editor-panel')
class EditorPanel extends PolymerElement {

  @property var selectedLabel;

  get selected {
    if (selectedLabel is String) {
      return int.parse(selectedLabel);
    }
    return selectedLabel;
  }

  EditorPanel.created() : super.created();

  BlockEditor onInitializeEditor;
  BlockEditor onActivatedEditor;
  BlockEditor onDeactivatedEditor;
  BlockEditor onExecuteEditor;

  PaperTabs tabs;

  @override
  void attached() {
    selectedLabel = "0";
    onInitializeEditor = $$('#on_initialize_editor');
    onActivatedEditor = $$('#on_activated_editor');
    onDeactivatedEditor = $$('#on_deactivated_editor');
    onExecuteEditor = $$('#on_execute_editor');
    tabs = $$('#menu-tabs');

    tabs.select(selected.toString());

    globalController.editorPanel = this;
    globalController.setMode('initialize');
  }

  get selectedApplication {
    switch (selected) {
      case 0:
        return globalController.onInitializeApp;
      case 1:
        return globalController.onActivatedApp;
      case 2:
        return globalController.onExecuteApp;
      case 3:
        return globalController.onDeactivatedApp;
    }
    return null;
  }


  void refresh() {
    selectedEditor.refresh(selectedApplication);
  }

  get selectedEditor {
    switch (selected) {
      case 0:
        return onInitializeEditor;
      case 1:
        return onActivatedEditor;
      case 2:
        return onExecuteEditor;
      case 3:
        return onDeactivatedEditor;
    }
    return null;
  }

  get selectedTab {
    switch (selected) {
      case 0:
        return $$('#on_initialize_tab');
      case 1:
        return $$('#on_activated_tab');
      case 2:
        return $$('#on_execute_tab');
      case 3:
        return $$('#on_deactivated_tab');
    }
    return null;
  }

  void onUpdateSelection() {
    if (globalController.selectedBox == null) {
      ($$('#up-button') as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($$('#down-button') as html.HtmlElement).style.backgroundColor = '#CACACA';
      ($$('#remove-button') as html.HtmlElement).style.backgroundColor = '#CACACA';
    } else {
      ($$('#up-button') as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($$('#down-button') as html.HtmlElement).style.backgroundColor = '#A1CF6B';
      ($$('#remove-button') as html.HtmlElement).style.backgroundColor = '#A1CF6B';
    }
  }

  void onSelectTab() {
    if (selected == 0) {
    } else if (selected == 1) {
    } else if (selected == 2) {
    } else if (selected == 3) {
    }
  }

  @reflectable
  void onSelectionUpdated(var e) {
  }

  @reflectable
  void onSelectInitialize(var e, var d) {
    globalController.setMode('initialize');
  }

  @reflectable
  void onSelectActivated(var e, var d) {
    globalController.setMode('activated');
  }

  @reflectable
  void onSelectExecute(var e, var d) {
    globalController.setMode('execute');
  }

  @reflectable
  void onSelectDeactivated(var e, var d) {
    globalController.setMode('deactivated');
  }

  @reflectable
  void onUp(var e, var d) {
    selectedEditor.onUp(e);
    e.stopPropagation();
  }

  @reflectable
  void onDown(var e, var d) {
    selectedEditor.onDown(e);
    e.stopPropagation();
  }

  @reflectable
  void onRemove(var e, var d) {
    selectedEditor.onRemove(e);
    e.stopPropagation();
  }

}