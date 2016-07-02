part of boxes;

@PolymerRegister('add-box')
class AddBox extends CalculationBox {

  static AddBox createBox(program.Add addBlock) {
    return (new html.Element.tag('add-box') as AddBox)
      ..model = addBlock
      ..attachLeft(BoxFactory.parseBlock(addBlock.a))
      ..attachRight(BoxFactory.parseBlock(addBlock.b));
  }

  AddBox.created() : super.created();
}