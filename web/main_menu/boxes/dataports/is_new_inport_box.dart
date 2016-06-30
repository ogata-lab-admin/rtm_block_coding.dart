library is_new_inport_box;

@HtmlImport('is_new_inport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html' as html;
import '../../../scripts/application.dart' as program;
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/iron_selector.dart';
import '../../../controller/controller.dart';
import '../box_base.dart';

@PolymerRegister('is-new-inport-box')
class IsNewInPortBox extends BoxBase {

  static IsNewInPortBox createBox(program.IsNewInPort m) {
    return new html.Element.tag('is-new-inport-box') as IsNewInPortBox
      ..model = m
      ..set('port_name', m.name)
      ..set('port_type', m.dataType.typename);
  }

  PolymerElement parentElement;

  @property String port_name = "defaultName";
  @property String port_type = "defaultType";

  IsNewInPortBox.created() : super.created();

  void attached() {
    updateInPortList();
    selectInPort(model.name);

    PaperDropdownMenu ndd = $['dropdown-menu'];
    ndd.addEventListener('iron-select', onIronSelected);
    ndd.on['core-select'].listen((var e) {

    });
  }

  void onIronSelected(var e) {
    if (e.detail != null) {

      String name_ = e.detail['item'].innerHtml;
      var pl = globalController.onInitializeApp.find(
          program.AddInPort, name: name_);
      if (pl.length > 0) {
        program.AddInPort inport = pl[0];
        model.name = name_;
        if ((model as program.IsNewInPort).dataType != inport.dataType) {
          (model as program.IsNewInPort).dataType = inport.dataType;
        }
      }

    }
  }


  void updateInPortList() {
    $$('#dropdown').children.clear();

    int counter = 0;
    var ports = globalController.onInitializeApp.find(program.AddInPort);
    ports.forEach((program.AddInPort p) {
      $$('#dropdown').children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = p.name
            ..setAttribute('value', counter.toString())
      );
      counter++;
    }
    );
  }

  void selectInPort(String name) {
    int counter = 0;
    $$('#dropdown').children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        ($$('#dropdown') as IronSelector).attrForSelected = ('value');
        ($$('#dropdown') as IronSelector).select(counter.toString());
        return;
      }
      counter++;
    });

    print('Invalid InPort is selected in inport_data');
  }


}