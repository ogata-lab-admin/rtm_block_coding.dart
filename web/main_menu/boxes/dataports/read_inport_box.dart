library read_inport_box;

@HtmlImport('read_inport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import '../../../scripts/application.dart' as program;
import '../box_base.dart';
import 'data_port_box.dart';

@PolymerRegister('read-inport-box')
class ReadInPortBox extends BoxBase {

  static ReadInPortBox createBox(program.ReadInPort m) {
    return new html.Element.tag('read-inport-box') as ReadInPortBox
      ..model = m;
  }

  ReadInPortBox.created() : super.created();

  PortSelector portSelector;

  void attached() {
    portSelector = $$('#port-selector');
    portSelector.updatePortList(program.AddInPort);
    portSelector.selectPort(model.name);
    portSelector.onSelect.listen((program.AddInPort p) {
      model.name = p.name;
      if ((model as program.ReadInPort).dataType != p.dataType) {
        (model as program.ReadInPort).dataType = p.dataType;
      }
    });
  }

}