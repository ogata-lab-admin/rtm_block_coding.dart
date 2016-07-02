part of boxes;

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
      onTypeChange((model as program.AddOutPort).dataType.typename);
    }
  }

  void onNameChange(String new_name) {
    String old_name = model.name;

    globalController.model.findFromAllApp(program.OutPortBuffer, old_name).forEach((program.OutPortBuffer port) {
      port.name = new_name;
    });

    globalController.model.findFromAllApp(program.WriteOutPort, old_name).forEach((program.WriteOutPort port) {
      port.name = new_name;
    });

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    (model as program.AddOutPort).dataType = new program.DataType.fromTypeName(typename);

    String name_ = model.name;

    globalController.model.findFromAllApp(program.OutPortBuffer, name_).forEach((program.OutPortBuffer port) {
      port.dataType = (model as program.AddOutPort).dataType;
    });

    globalController.model.findFromAllApp(program.WriteOutPort, name_).forEach((program.WriteOutPort port) {
      port.dataType = (model as program.AddOutPort).dataType;
      //port.accessSequence = '';
    });
  }



}

