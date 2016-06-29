library block_editor;

@HtmlImport('block_editor.html')
import 'dart:html' as html;
import 'package:web_components/web_components.dart' show HtmlImport;

//import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import '../scripts/application.dart' as program;
import '../controller/controller.dart';
import 'boxes/box_factory_impl.dart';

import 'boxes/rtm/add_inport_box.dart';
import 'boxes/rtm/add_outport_box.dart';
import 'boxes/rtm/add_port_box.dart';
import 'boxes/variables/assign_box.dart';
import 'boxes/variables/declare_variable_box.dart';
import 'boxes/variables/refer_variable_box.dart';

@PolymerRegister('block-editor')
class BlockEditor extends PolymerElement {

  @property String command;

  BlockEditor.created() : super.created();

  /*
  var up_offset = [-20, 100];
  var down_offset = [-20, 180];
  var delete_offset = [-20, 260];
  */

  get container => $$('#block-container');

  @override
  void attached() {
  }

  @reflectable
  void onClicked(var e, var d) {
    print('BlockEditor.onClicked()');
    globalController.setSelectedBox(null);
    //globalController.setSelectedElem(e, globalController.selectedElement);
    //e.stopPropagation();
  }

  void refresh(program.Application app) {
    container.children.clear();
    app.statements.forEach((s) {
      new BoxFactoryImpl().parseStatement(container.children, s);
    });
  }

  void delete(program.StatementList slist, var elem) {
    var stat = null;
    slist.forEach(
        (var s) {
      if (s.block == elem.model) {
        stat = s;
      }
    }
    );
    if (stat != null) {
      slist.remove(stat);
    }
  }

  void onUp(var e) {
    var selected = globalController.selectedBox;
    if (selected == null) return;

    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index--;
        if (index >= 0) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedBox(selected);
          globalController.refreshPanel();
          //updateClick();
        }
      }
    }
  }

  void onDown(var e) {
    var selected = globalController.selectedBox;
    if (selected == null) return;

    program.Statement s = selected.model.parent;
    if (s != null) {
      program.StatementList sl = s.parent;
      if (sl != null) {
        var index = sl.indexOf(s);
        index++;
        if (index < sl.length) {
          sl.remove(s);
          sl.insert(index, s);

          globalController.setSelectedBox(selected);
          globalController.refreshPanel();
          //updateClick();
        }
      }
    }
  }

  void onRemove(var e) {
    var selected = globalController.selectedBox;
    if (selected == null) return;

    if (selected.parent == container) {
      delete(globalController.selectedApp.statements, selected);
    }
    globalController.setSelectedBox(null);
    globalController.refreshPanel();

    //updateClick();

  }

}