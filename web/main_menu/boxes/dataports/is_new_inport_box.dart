part of boxes;

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