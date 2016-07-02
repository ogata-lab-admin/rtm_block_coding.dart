part of boxes;

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