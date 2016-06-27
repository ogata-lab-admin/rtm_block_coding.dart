library add_inport_box;

@HtmlImport('add_inport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html' as html;
import '../../scripts/application.dart' as program;
import 'add_port_box.dart';
import '../../controller/controller.dart';
import 'add_port_box.dart';

@PolymerRegister('add-inport-box')
class AddInPortBox extends AddPortBox {

  DataTypeDropDown dataTypeDropDown;

  static  AddInPortBox createBox(program.AddInPort m) {
    return new html.Element.tag('add-inport-box') as AddPortBox
      ..model = m;
  }

  AddInPortBox.created() : super.created();

  void attached() {
    dataTypeDropDown = $$('#datatype-dropdown');
    dataTypeDropDown.model = model;
    dataTypeDropDown.onSelect.listen(onIronSelect);
  }

  @reflectable
  void onNameChanged(var e, var d) {
    onNameChange(port_name);
  }

  @reflectable
  void onIronSelect(var e) {
    print('AddInPort.onIronSelect($e, ${e.detail})');
    if (e.detail != null) {
      onTypeChange(model.dataType.typename);
    }
  }

  void onNameChange(String new_name) {
    print('AddInPortBox.onNameChange($new_name)');
    String old_name = model.name;

    globalController.findFromAllApp(program.AccessInPort, old_name).forEach((program.AccessInPort port) {
      port.name = new_name;
    });

    globalController.findFromAllApp(program.ReadInPort, old_name).forEach((program.ReadInPort port) {
      port.name = new_name;
    });

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    print('AddInPort.onTypeChange($typename)');

    String name_ = model.name;
    globalController.findFromAllApp(program.AccessInPort, name_).forEach((program.AccessInPort port) {
      port.dataType = model.dataType;
      port.accessSequence = '';
    });

    globalController.findFromAllApp(program.ReadInPort, name_).forEach((program.ReadInPort port) {
      port.dataType = model.dataType;
      //port.accessSequence = '';
    });
  }



}

