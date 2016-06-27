library add_outport_box;


@HtmlImport('add_outport_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:html' as html;
import '../../scripts/application.dart' as program;
import '../../controller/controller.dart';
import 'add_port_box.dart';

@PolymerRegister('add-outport-box')
class AddOutPortBox extends AddPortBox {

  static AddOutPortBox createBox(program.AddOutPort m) {
    return new html.Element.tag('add-outport-box') as AddOutPortBox
      ..model = m;
  }

  DataTypeDropDown dataTypeDropDown;


  AddOutPortBox.created() : super.created();

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
    print('AddOutPort.onIronSelect($e, ${e.detail})');
    if (e.detail != null) {
      onTypeChange(model.dataType.typename);
    }
  }

  void onNameChange(String new_name) {
    String old_name = model.name;

    globalController.findFromAllApp(program.AccessOutPort, old_name).forEach((program.AccessOutPort port) {
      port.name = new_name;
    });

    globalController.findFromAllApp(program.WriteOutPort, old_name).forEach((program.WriteOutPort port) {
      port.name = new_name;
    });

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    model.dataType = new program.DataType.fromTypeName(typename);

    String name_ = model.name;

    globalController.findFromAllApp(program.AccessOutPort, name_).forEach((program.AccessOutPort port) {
      port.dataType = model.dataT
    });

    globalController.findFromAllApp(program.WriteOutPort, name_).forEach((program.WriteOutPort port) {
      port.dataType = model.dataType;
      //port.accessSequence = '';
    });
  }



}

