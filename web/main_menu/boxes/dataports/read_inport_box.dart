part of boxes;

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