library write_outport_box;

@HtmlImport('write_outport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../../scripts/application.dart' as program;
import '../../../controller/controller.dart';
import '../box_base.dart';
import 'data_port_box.dart';

@PolymerRegister('write-outport-box')
class WriteOutPortBox extends BoxBase {

  static WriteOutPortBox createBox(program.WriteOutPort m) {
    return new html.Element.tag('write-outport-box') as WriteOutPortBox
      ..model = m;
  }

  WriteOutPortBox.created() : super.created();

  PortSelector portSelector;

  void attached() {
    portSelector = $$('#port-selector');
    portSelector.updatePortList(program.AddOutPort);
    portSelector.selectPort(model.name);
    portSelector.onSelect.listen((program.AddOutPort p) {
      model.name = p.name;
      if ((model as program.WriteOutPort).dataType != p.dataType) {
        (model as program.WriteOutPort).dataType = p.dataType;
      }
    });
  }
}