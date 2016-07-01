library is_new_inport_box;

@HtmlImport('is_new_inport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../../scripts/application.dart' as program;
import '../box_base.dart';
import 'data_port_box.dart';

@PolymerRegister('is-new-inport-box')
class IsNewInPortBox extends BoxBase {

  static IsNewInPortBox createBox(program.IsNewInPort m) {
    return new html.Element.tag('is-new-inport-box') as IsNewInPortBox
      ..model = m
      ..set('port_name', m.name)
      ..set('port_type', m.dataType.typename);
  }

  @property String port_name = "defaultName";
  @property String port_type = "defaultType";

  IsNewInPortBox.created() : super.created();

  PortSelector portSelector;

  void attached() {
    portSelector = $$('#port-selector');
    portSelector.updatePortList(program.AddInPort);
    portSelector.selectPort(model.name);
    portSelector.onSelect.listen((program.AddInPort p) {
      model.name = p.name;
      if ((model as program.IsNewInPort).dataType != p.dataType) {
        (model as program.IsNewInPort).dataType = p.dataType;
      }
    });

  }

}