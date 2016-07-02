part of boxes;

@PolymerRegister('subtract-box')
class SubtractBox extends CalculationBox {

  static SubtractBox createBox(program.Subtract subtractBlock) {
    return (new html.Element.tag('subtract-box') as SubtractBox)
        ..model = subtractBlock
        ..attachLeft(BoxFactory.parseBlock(subtractBlock.a))
        ..attachRight(BoxFactory.parseBlock(subtractBlock.b));
  }

  SubtractBox.created() : super.created();

}